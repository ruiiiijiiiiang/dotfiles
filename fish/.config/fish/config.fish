# Global functions and variables

set -U fish_user_paths /home/rui/.local/bin /home/rui/.bun/bin /home/rui/.cargo/bin /home/rui/.deno/bin /usr/local/sbin /usr/local/bin /usr/bin /usr/bin/core_perl

# Login shell - Environment setup and one-time initializations
if status is-login
    # Tool initializations
    zoxide init fish | source
    starship init fish | source
    fzf --fish | source
    atuin init fish | source
    pay-respects fish --alias | source
end

# Interactive shell - Shell behavior and user interface
if status is-interactive
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

    # Interactive functions
    function run-ls-on-cd -v PWD
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

    function fish_greeting
        fastfetch
    end
end
