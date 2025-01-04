if status is-interactive
    function run-ls-on-cd -v PWD
        command lsd -l
    end
end

if status is-login
    set -gx EDITOR nvim
    set -gx MANROFFOPT -c
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

    thefuck --alias | source

    alias l="lsd"
    alias ls="lsd"
    alias ll="lsd -l"
    alias lt="lsd --tree"
    alias lta="lsd --tree -a"
    alias nv="nvim"
    alias cat="bat"
    alias vg="ssh veggie.ooapi.com"
    alias lg="lazygit"

    # zoxide
    zoxide init fish | source
    function cd
        z $argv
    end

    # leave directories
    function qcd
        echo cd (string repeat -n (string length $argv) ../)
    end
    abbr -a qcd --position command --regex "q+" --function qcd

    # yazi
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    # starship
    # function starship_transient_prompt_func
    #     starship module character
    # end
    starship init fish | source
    #enable_transience

    # fzf
    fzf --fish | source
    function fzf
        nvim $(command fzf --preview "bat --style=numbers --color=always --line-range :500 {}")
    end
    set -gx FZF_DEFAULT_OPTS "\
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
--color=marker:#babbf1,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284 \
--color=selected-bg:#51576d \
--multi"

    function fish_greeting
        if command -v catnap >/dev/null 2>&1
            catnap
        else
            fastfetch
        end
    end
end
