# Outside both blocks - Function definitions needed everywhere
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

# Login shell - Environment setup and one-time initializations
if status is-login
    # Tool initializations
    thefuck --alias | source
    zoxide init fish | source
    starship init fish | source
    fzf --fish | source
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

    function fzf
        nvim $(command fzf --preview "bat --style=numbers --color=always --line-range :500 {}")
    end

    function fish_greeting
        sleep 0.1
        fastfetch
        # if command -v catnap >/dev/null 2>&1
        #     catnap
        # else
        #     fastfetch
        # end
    end
end
