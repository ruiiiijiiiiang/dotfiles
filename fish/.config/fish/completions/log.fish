complete -c log -f

complete -c log -n "__fish_is_nth_token 1" -a "(__fish_systemd_services)"

complete -c log -n "__fish_is_nth_token 2" -a "10 20 50 100"

complete -c restart-log -w log
