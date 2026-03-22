if status is-login
    set -U fish_user_paths /home/rui/.local/bin /home/rui/.bun/bin /home/rui/.cargo/bin /home/rui/.deno/bin /usr/local/sbin /usr/local/bin /usr/bin /usr/bin/core_perl
end

# Interactive shell - Shell behavior and user interface
if status is-interactive
    # Tool initializations
    zoxide init fish | source
    starship init fish | source
    fzf --fish | source
    atuin init fish | source
    pay-respects fish --alias | source
    carapace _carapace | source
    navi widget fish | source

    fish_config theme choose catppuccin

    # Aliases
    alias ls="lsd"
    alias cat="bat"

    # Abbreviations
    abbr -a l lsd
    abbr -a lt "lsd --tree"
    abbr -a lta "lsd --tree -a"
    abbr -a nv nvim
    abbr -a lg lazygit
    abbr -a qcd --position command --regex "q+" --function qcd
    abbr -a vg "ssh veggie.ooapi.com"

    set -g fish_key_bindings fish_vi_key_bindings

    # Interactive functions
    function run-ls-on-cd -v PWD
        set current_repository (git rev-parse --show-toplevel 2> /dev/null)
        if command -q onefetch && [ "$current_repository" ] && [ "$current_repository" != "$last_repository" ]
            onefetch
        end
        set -gx last_repository $current_repository
        command lsd -l
    end

    function cd
        z $argv
    end

    function rm
        command rm -Iv $argv
    end

    function fzf
        nvim $(command fzf --preview "bat --style=numbers --color=always --line-range :500 {}")
    end

    function qcd
        echo cd (string repeat -n (string length $argv) ../)
    end

    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    function open
        if command -q open
            command open $argv &
        else if command -q xdg-open
            xdg-open $argv &
        else
            echo "Error: Neither 'open' nor 'xdg-open' command found." >&2
            return 1
        end
    end

    function hx
        if command -q hx
            command hx $argv
        else if command -q helix
            helix $argv
        else
            echo "Helix not installed"
            return 1
        end
    end

    function yay
        env PATH="/usr/bin:$PATH" \
            LD_PRELOAD="" \
            LD_LIBRARY_PATH="" \
            PKG_CONFIG_PATH="" \
            PKG_CONFIG_LIBDIR="" \
            CFLAGS="" \
            CXXFLAGS="" \
            LDFLAGS="" \
            MAKEFLAGS="" \
            CC="" \
            yay $argv
    end

    function np
        set -l packages
        for arg in $argv
            set packages $packages $arg
        end

        if test (count $packages) -gt 0
            nix-shell -p $packages --command "exec fish -l"
        else
            nix-shell --command "exec fish -l"
        end
    end

    function stats
        systemctl status $argv[1] | tspin
    end

    function log
        if count $argv >1
            journalctl -u $argv[1] -n $argv[2] | tspin
        else
            journalctl -u $argv[1] -f | tspin
        end
    end

    function fish_greeting
        fastfetch
    end
end
