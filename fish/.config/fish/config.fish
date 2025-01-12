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
    # Environment variables
    set -gx EDITOR nvim
    set -gx MANROFFOPT -c
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
    set -gx FZF_DEFAULT_OPTS "\
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
--color=marker:#babbf1,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284 \
--color=selected-bg:#51576d \
--multi"

    # Case-insensitive completion
    set -g fish_complete_path case-insensitive

    # Show completion descriptions
    set -g fish_complete_descriptions 1

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
