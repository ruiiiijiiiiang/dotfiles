complete -c log -e
complete -c restart-log -e

complete -c log -f
complete -c log -n "__fish_is_nth_token 1" -a "(systemctl list-units --type=service --all --no-legend | string trim | while read -l unit load active sub desc; printf '%s\t%s\n' \$unit \$desc; end)"

complete -c restart-log -w log
