function agenix_rekey_readable --description 'Rekey agenix secrets readable with a local SSH identity'
    set -l original_args $argv
    argparse 'i/identity=' 'r/repo=' 'n/dry-run' 'h/help' -- $argv
    or return 2

    if set -q _flag_help
        echo 'Usage: agenix_rekey_readable [--identity PRIVATE_KEY] [--repo PATH] [--dry-run]'
        return 0
    end

    if test (count $argv) -ne 0
        echo 'Error: Unexpected positional arguments.' >&2
        return 2
    end

    set -l repo "$HOME/nixos-config"
    if set -q _flag_repo
        set repo $_flag_repo
    end
    set repo (path resolve -- "$repo")
    or return 1

    set -l rules "$repo/secrets/secrets.nix"
    if not test -f "$rules"
        echo "Error: Agenix rules not found at $rules." >&2
        return 1
    end
    if not test -f "$repo/lib/keys.nix"
        echo "Error: Agenix keys not found at $repo/lib/keys.nix." >&2
        return 1
    end

    set -l identity "$HOME/.ssh/id_ed25519"
    if set -q _flag_identity
        set identity $_flag_identity
    end
    set identity (path resolve -- "$identity")
    or return 1

    if not test -r "$identity"
        echo "Error: SSH identity is not readable: $identity" >&2
        return 1
    end

    for dependency in nix nix-instantiate
        if not command -q $dependency
            echo "Error: Required command not found: $dependency" >&2
            return 1
        end
    end

    if not command -q agenix
        if set -q AGENIX_REKEY_IN_NIX_SHELL
            echo 'Error: agenix is unavailable inside the Nix shell.' >&2
            return 1
        end

        set -l function_file (functions --details agenix_rekey_readable)
        if not test -f "$function_file"
            echo 'Error: Cannot find the fish function file to load in the Nix shell.' >&2
            return 1
        end

        # Keep agenix available without requiring a flake in the copied secrets directory.
        set -l agenix_flake github:ryantm/agenix
        env AGENIX_REKEY_IN_NIX_SHELL=1 nix shell "$agenix_flake" --command fish -c \
            'source "$argv[1]"; agenix_rekey_readable $argv[2..]' \
            -- "$function_file" $original_args
        return $status
    end

    set -l files (nix-instantiate --eval --raw \
        --expr '{ rules }: builtins.concatStringsSep "\n" (builtins.attrNames (import (builtins.toPath rules)))' \
        --argstr rules "$rules")
    or return 1

    set -l eligible 0
    set -l skipped 0
    for file in $files
        if not test -f "$repo/secrets/$file"
            echo "Error: Encrypted file not found: $file" >&2
            return 1
        end

        if env AGENIX_RULES="$rules" agenix -d "$file" -i "$identity" >/dev/null 2>&1
            if set -q _flag_dry_run
                echo "Would rekey $file"
            else
                echo "Rekeying $file"
                env AGENIX_RULES="$rules" EDITOR=: agenix -e "$file" -i "$identity"
                or return 1
            end
            set eligible (math $eligible + 1)
        else
            set skipped (math $skipped + 1)
        end
    end

    echo "Eligible: $eligible; unreadable: $skipped"
end
