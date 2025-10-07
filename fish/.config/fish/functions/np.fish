function np
    set -l packages
    # Collect all arguments passed to the function
    for arg in $argv
        set packages $packages $arg
    end

    if test (count $packages) -gt 0
        # Use 'nix-shell -p' to set up the environment,
        # and then use '--command' to run 'fish -l' inside it.
        nix-shell -p $packages --command "exec fish -l"
    else
        # If no packages are given, just run nix-shell normally
        nix-shell --command "exec fish -l"
    end
end

alias nixp='np'
