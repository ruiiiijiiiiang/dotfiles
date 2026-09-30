function nix_deploy
    argparse d/debug -- $argv
    or return

    set -l host $argv[1]
    set -l mode $argv[2]

    if test -z "$host"
        echo "Usage: nix_deploy <host|rollout> [mode] [-d|--debug]"
        return 1
    end

    if test -z "$mode"
        set mode switch
    end

    if test "$host" = rollout
        set -l rollout_flags
        if set -q _flag_debug
            set rollout_flags --debug
        end

        for rollout_host in cloud-observe vm-public vm-monitor vm-app vm-network hypervisor
            nix_deploy $rollout_flags $rollout_host $mode
            or return
        end
        return
    end

    set -l common_flags \
        --target-host "root@$host" \
        --flake "/home/rui/nixos-config#$host"
    if set -q _flag_debug
        set common_flags $common_flags --show-trace --verbose --print-build-logs
    end

    echo "Deploying to $host ($mode)..."
    if command -q nixos-rebuild
        nixos-rebuild $mode $common_flags
    else
        nix run nixpkgs#nixos-rebuild -- $mode $common_flags
    end
end
