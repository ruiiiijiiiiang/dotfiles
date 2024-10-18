if status is-interactive
    function run-ls-on-cd -v PWD
        ls -lF
    end
end

if status is-login
    fish_add_path /opt/homebrew/bin

    thefuck --alias | source
    zoxide init fish | source
    fzf --fish | source
    starship init fish | source

    alias ls="lsd"
    alias lt="lsd --tree"
    alias lta="lsd --tree -a"
    alias nv="nvim"
    alias cat="bat"
    alias vg="ssh veggie.ooapi.com"

    function cd
        z $argv
    end

    function qcd
        echo cd (string repeat -n (string length $argv) ../)
    end
    abbr -a qcd --position command --regex 'q+' --function qcd

    function nvfzf
        nvim $(fzf)
    end

    function fzfp
        fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'
    end

    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    set -g fish_key_bindings fish_vi_key_bindings
    set -g fish_greeting '
          _______  _        _______
|\     /|(  ___  )( \      (  ___  )
( \   / )| (   ) || (      | (   ) |
 \ (_) / | |   | || |      | |   | |
  \   /  | |   | || |      | |   | |
   ) (   | |   | || |      | |   | |
   | |   | (___) || (____/\| (___) |
   \_/   (_______)(_______/(_______)
 _______           _______  _______
(  ____ \|\     /|(  ___  )(  ____ \
| (    \/| )   ( || (   ) || (    \/
| (_____ | | _ | || (___) || |
(_____  )| |( )| ||  ___  || | ____
      ) || || || || (   ) || | \_  )
/\____) || () () || )   ( || (___) |
\_______)(_______)|/     \|(_______)'
    set -gx EDITOR nvim
    set -gx FZF_DEFAULT_OPTS "\
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
--color=marker:#babbf1,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284 \
--color=selected-bg:#51576d \
--multi"
end
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
