function nixup --description "Check if a nixpkgs package (or all installed) has a newer version on a channel before rebuilding"
    argparse a/all c/changed-only h/help -- $argv
    or return 1

    if set -q _flag_help; or begin
            test (count $argv) -eq 0; and not set -q _flag_all
        end
        echo "Usage: nixup <pkg> [branch]        # compare your pinned version vs a channel"
        echo "       nixup -a|--all [branch]      # do it for every installed package"
        echo ""
        echo "  nixup neovim                 # neovim: pinned vs latest unstable"
        echo "  nixup neovim stable          # vs the current stable channel"
        echo "  nixup ripgrep nixos-25.05    # vs an explicit release channel"
        echo "  nixup --all                  # sweep all installed pkgs, unstable"
        echo "  nixup -a -c stable           # sweep, list ONLY pkgs with a diff"
        echo ""
        echo "branch: unstable (default) | unstable-small | stable | master"
        echo "        | nixos-X<.YY> | any flake ref"
        echo ""
        echo "'current' = what your system nixpkgs pin evaluates to right now"
        echo "'latest'  = the tip of the requested channel (--refresh'd each run)"
        return (set -q _flag_help; and echo 0; or echo 1)
    end

    if not command -q nix
        echo "nixup: 'nix' not found on PATH"
        return 1
    end

    # --- resolve branch alias -> a flake ref pointing at the tested channel -----
    # Channels (channels.nixos.org via the registry) are what a rebuild actually
    # pulls, so we compare against those rather than raw github branch tips.
    set -l branch $argv[-1]
    # In single-pkg mode the last arg is the branch ONLY if there's more than the pkg.
    if not set -q _flag_all; and test (count $argv) -lt 2
        set branch unstable
    end
    if set -q _flag_all; and test (count $argv) -eq 0
        set branch unstable
    end

    set -l ref
    set -l label
    switch $branch
        case unstable ''
            set ref nixpkgs/nixos-unstable
            set label unstable
        case unstable-small small
            set ref nixpkgs/nixos-unstable-small
            set label unstable-small
        case stable
            # Highest nixos-XX.YY known to the registry == current stable channel.
            set -l chan (nix registry list 2>/dev/null \
                | string match -r 'nixos-[0-9]+\.[0-9]+(?!-)' \
                | sort -uV | tail -1)
            if test -z "$chan"
                echo "nixup: couldn't resolve 'stable' from the registry"
                return 1
            end
            set ref nixpkgs/$chan
            set label $chan
        case master
            set ref github:NixOS/nixpkgs/master
            set label master
        case 'nixos-*'
            set ref nixpkgs/$branch
            set label $branch
        case '*'
            # Fall through: treat the arg as a full flake ref.
            set ref $branch
            set label $branch
    end

    # --- helper: direction between two version strings via `sort -V` ------------
    # Prints '->' (channel newer), '<-' (local newer), or '==' (equal).
    function __nixup_dir --no-scope-shadowing
        test "$argv[1]" = "$argv[2]"; and echo '=='; and return
        set -l top (printf '%s\n%s\n' $argv[1] $argv[2] | sort -V | tail -1)
        test "$top" = "$argv[2]"; and echo '->'; or echo '<-'
    end

    # ===========================================================================
    # SINGLE PACKAGE
    # ===========================================================================
    if not set -q _flag_all
        set -l pkg $argv[1]
        echo "Checking $pkg on $label …" >&2

        set -l cur (nix eval --raw nixpkgs#$pkg.version 2>/dev/null)
        set -l new (nix eval --raw --refresh $ref#$pkg.version 2>/dev/null)

        if test -z "$new"
            echo "$pkg: not found on $label (bad attr name?)"
            return 1
        end
        if test -z "$cur"
            set cur "(not pinned/installed)"
        end

        set -l dir (__nixup_dir "$cur" "$new")
        switch $dir
            case '=='
                echo "$pkg: $cur  (up to date on $label)"
            case '->'
                set_color green
                echo "$pkg: $cur -> $new  (update available on $label)"
                set_color normal
            case '<-'
                set_color yellow
                echo "$pkg: $cur <- $new  (local is newer than $label)"
                set_color normal
        end
        return 0
    end

    # ===========================================================================
    # ALL INSTALLED PACKAGES
    # ===========================================================================
    # Enumerate both the system profile and the home-manager profile, parse
    # pname/version straight off the store paths, then look every pname up on the
    # target channel in ONE evaluation (getFlake + tryEval so misses don't abort).
    echo "Collecting installed packages …" >&2

    set -l profiles /run/current-system/sw /etc/profiles/per-user/$USER ~/.nix-profile
    set -l pnames
    set -l curvers

    for prof in $profiles
        test -e $prof; or continue
        for path in (nix-store -q --references $prof 2>/dev/null)
            set -l base (string replace -r '^/nix/store/[a-z0-9]{32}-' '' -- $path)
            # Drop trailing output suffixes so foo-1.2-man dedupes with foo-1.2.
            set base (string replace -r -- '-(man|dev|bin|doc|lib|out|info|debug)$' '' $base)
            # Split at the first '-<digit>': everything before is the pname.
            set -l m (string match -r '^(.+?)-([0-9].*)$' -- $base)
            test (count $m) -eq 3; or continue
            # Skip dupes (same pname from multiple profiles/outputs).
            contains -- $m[2] $pnames; and continue
            set -a pnames $m[2]
            set -a curvers $m[3]
        end
    end

    if test (count $pnames) -eq 0
        echo "nixup: no installed packages found to check"
        return 1
    end
    echo "Looking up "(count $pnames)" packages on $label (one eval, may take a bit) …" >&2

    # Build the nix list literal: "a" "b" "c"
    set -l quoted
    for n in $pnames
        set -a quoted '"'$n'"'
    end
    set -l expr 'let f = builtins.getFlake "'$ref'";
        p = f.legacyPackages.${builtins.currentSystem};
    in builtins.listToAttrs (map (n: {
        name = n;
        value = (builtins.tryEval (p.${n}.version or null)).value;
    }) [ '(string join ' ' $quoted)' ])'

    set -l json (nix eval --impure --refresh --json --expr $expr 2>/dev/null)
    if test -z "$json"
        echo "nixup: evaluation against $ref failed"
        return 1
    end

    # Walk each pname, pull the channel version out of the JSON with jq, compare.
    set -l n_update 0
    set -l n_same 0
    set -l n_newer 0
    set -l n_skip 0
    for i in (seq (count $pnames))
        set -l pn $pnames[$i]
        set -l cur $curvers[$i]
        set -l new (echo $json | jq -r --arg k $pn '.[$k] // empty' 2>/dev/null)
        if test -z "$new"
            set n_skip (math $n_skip + 1)
            continue
        end
        set -l dir (__nixup_dir "$cur" "$new")
        switch $dir
            case '=='
                set n_same (math $n_same + 1)
                set -q _flag_changed_only; and continue
                printf '  %-28s %s\n' $pn "$cur (up to date)"
            case '->'
                set n_update (math $n_update + 1)
                set_color green
                printf '  %-28s %s\n' $pn "$cur -> $new"
                set_color normal
            case '<-'
                set n_newer (math $n_newer + 1)
                set_color yellow
                printf '  %-28s %s\n' $pn "$cur <- $new (local newer)"
                set_color normal
        end
    end

    echo ""
    echo "$label: $n_update update(s), $n_same up to date, $n_newer local-newer, $n_skip unresolved" >&2
end
