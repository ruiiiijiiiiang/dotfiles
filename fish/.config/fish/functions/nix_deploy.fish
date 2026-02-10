function nix_deploy
    argparse d/debug -- $argv
    or return

    set -l host $argv[1]
    set -l mode $argv[2]

    if test -z "$host"
        echo "Usage: deploy <host> [mode] [-d|--debug]"
        return 1
    end

    if test -z "$mode"
        set mode switch
    end

    set -l common_flags --target-host "root@$host" \
        --build-host "root@$host" \
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
