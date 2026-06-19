function battery_limit --description "View or set battery charge threshold limit"
    set -l target "/sys/class/power_supply/BAT1/charge_control_end_threshold"

    if not test -f $target
        echo "Error: Battery charge threshold interface not found at $target" >&2
        return 1
    end

    if test (count $argv) -eq 0
        # Output the current limit
        cat $target
        return 0
    end

    if test (count $argv) -gt 1
        echo "Error: Expected at most 1 argument, got "(count $argv) >&2
        echo "Usage: battery_limit [1-100]" >&2
        return 1
    end

    set -l limit $argv[1]

    # Validate that it is a positive integer
    if not string match -q -r '^[0-9]+$' -- $limit
        echo "Error: Input must be a positive integer between 1 and 100" >&2
        return 1
    end

    # Validate range
    if test $limit -lt 1 -o $limit -gt 100
        echo "Error: Input must be between 1 and 100 (got $limit)" >&2
        return 1
    end

    # Write the limit (requires sudo)
    echo "Setting battery charge limit to $limit%..."
    echo $limit | sudo tee $target > /dev/null
end
