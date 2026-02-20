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
        --flake "/home/rui/nixos-config#$host" \
        --option extra-substituters "https://cache.ruijiang.me https://cache.nixos.org https://nix-community.cachix.org" \
        --option extra-trusted-public-keys "cache.ruijiang.me-1:uSB517/xV6UnlCkzOYvmCSRG0sOqPPAGla5tY4iSQf0= cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="

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
