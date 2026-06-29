function wezterm_explorer
    # Inform WezTerm that this is the explorer pane by setting the user variable.
    # "explorer" base64 encoded is "ZXhwbG9yZXI="
    printf "\033]1337;SetUserVar=WEZTERM_ROLE=ZXhwbG9yZXI=\007"

    # Hide the cursor and restore cursor on exit
    printf "\033[?25l"
    function cleanup_explorer --on-event fish_exit
        printf "\033[?25h"
    end

    function _render_dir
        printf "\033[2J\033[3J\033[1;1H"

        if command -q lsd
            lsd -A -F --icon=always --color=always
        else
            ls -A -F --color=always
        end

        echo ""
        echo -e "\e[2;37m────────────────────────────────────────\e[0m"
        echo -e "\e[1;35m 📂 \e[1;36m$PWD\e[0m"
    end

    _render_dir

    while read -P "" -l target_dir
        set target_dir (string trim $target_dir)
        if test "$target_dir" = q -o "$target_dir" = exit
            break
        end
        if test -d "$target_dir"
            builtin cd $target_dir
            _render_dir
        end
    end
end
