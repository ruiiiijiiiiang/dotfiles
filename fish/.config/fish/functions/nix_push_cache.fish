function nix_push_cache --description "Build host configurations locally and push them to the vm-app harmonia cache"
    set -l hosts framework desktop hypervisor vm-network vm-app vm-monitor vm-public vm-cyber pi
    set -l targets $argv

    if test (count $targets) -eq 0
        set targets $hosts
    end

    set -l cache_host vm-app
    set -l gc_root /var/lib/nix-cache-roots
    set -l config_dir "$HOME/nixos-config"

    if not test -d "$config_dir"
        echo "Error: Directory $config_dir not found." >&2
        return 1
    end

    # Navigate to nixos-config to evaluate the local configurations
    pushd $config_dir

    echo "Updating flake inputs..."
    nix flake update --no-warn-dirty
    if test $status -ne 0
        echo "Error: Failed to update flake" >&2
        popd
        return 1
    end

    for host in $targets
        if not contains $host $hosts
            echo "Warning: '$host' is not a recognized host. Attempting to build anyway..."
        end

        echo "=========================================="
        echo "Building system closure for: $host"
        echo "=========================================="

        set -l store_path (nix build ".#nixosConfigurations.$host.config.system.build.toplevel" --print-out-paths --no-link --no-warn-dirty)
        if test $status -ne 0
            echo "Error: Failed to build $host" >&2
            continue
        end

        echo "Pushing $host ($store_path) to $cache_host..."
        nix copy --no-check-sigs --to "ssh-ng://root@$cache_host" "$store_path"
        if test $status -ne 0
            echo "Error: Failed to copy store paths to $cache_host" >&2
            continue
        end

        echo "Registering GC root on $cache_host..."
        ssh root@$cache_host "ln -sfn $store_path $gc_root/$host"
        if test $status -ne 0
            echo "Error: Failed to register GC root on $cache_host" >&2
            continue
        end

        echo "Done with $host."
    end

    popd
end
