function nix_deploy --description "Build and cache host configurations, optionally switching or preparing the next boot"
    argparse d/debug -- $argv
    or return

    if test (count $argv) -gt 2
        echo "Usage: nix_deploy <host|all> [cache|switch|boot] [-d|--debug]" >&2
        return 1
    end

    set -l targets cloud-observe vm-public vm-monitor vm-app vm-network hypervisor framework desktop
    if test (count $argv) -gt 1
        set targets $argv[1]
    end

    set -l mode cache
    if test (count $argv) -eq 2
        set mode $argv[2]
    end
    if not contains -- $mode cache switch boot
        echo "Error: Mode must be cache, switch, or boot." >&2
        return 1
    end

    set -l config_dir "$HOME/nixos-config"
    set -l cache_host vm-app
    set -l gc_root /var/lib/nix-cache-roots
    if not test -d "$config_dir"
        echo "Error: Directory $config_dir not found." >&2
        return 1
    end

    set -l debug_flags
    if set -q _flag_debug
        set debug_flags --show-trace --verbose --print-build-logs
    end

    echo "Updating flake inputs..."
    nix flake update --flake "$config_dir" --no-warn-dirty $debug_flags
    or return

    for target in $targets
        echo "Building system closure for $target..."
        set -l store_path (nix build "$config_dir#nixosConfigurations.$target.config.system.build.toplevel" --print-out-paths --no-link --no-warn-dirty $debug_flags)
        if test $status -ne 0
            echo "Error: Failed to build $target." >&2
            return 1
        end

        echo "Pushing $target ($store_path) to $cache_host..."
        nix copy --no-check-sigs --to "ssh-ng://root@$cache_host" "$store_path" $debug_flags
        or return

        echo "Registering GC root on $cache_host..."
        ssh root@$cache_host "ln -sfn $store_path $gc_root/$target"
        or return

        if test "$mode" != cache
            echo "Deploying to $target ($mode)..."
            set -l deploy_flags --target-host "root@$target" --store-path "$store_path" $debug_flags
            if command -q nixos-rebuild
                nixos-rebuild $mode $deploy_flags
            else
                nix run nixpkgs#nixos-rebuild -- $mode $deploy_flags
            end
            or return
        end

        echo "Done with $target ($mode)."
    end
end
