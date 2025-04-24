#!/usr/bin/env bash

# Function to check for active SSH connections
has_active_ssh() {
	ss -t -a | grep ":22 " | grep -v "127.0.0.1" | grep -v "::1" | awk '{print $5}' | grep -v -E '^$' | grep -v LISTEN >/dev/null 2>&1
	return $?
}

# Function to run swayidle
run_swayidle() {
	swayidle -w \
		timeout 600 'swaylock -f' \
		timeout 1200 'systemctl suspend' \
		timeout 1800 'systemctl hibernate' \
		before-sleep 'swaylock -f'
}

# Main loop to continuously check for SSH and manage swayidle
while true; do
	if ! has_active_ssh; then
		# No active SSH, run swayidle in the background
		run_swayidle &
		swayidle_pid=$! # Capture the process ID of swayidle

		# Keep checking for SSH while swayidle is running
		while kill -0 $swayidle_pid 2>/dev/null; do
			if has_active_ssh; then
				# SSH connection detected, kill swayidle
				kill $swayidle_pid
				wait $swayidle_pid # Wait for swayidle to terminate
				echo "Active SSH connection detected. Swayidle stopped."
				break # Break out of the inner loop to re-check
			fi
			sleep 60
		done
	else
		# Active SSH connection, ensure swayidle is not running
		if [ -n "$swayidle_pid" ] && kill -0 $swayidle_pid 2>/dev/null; then
			kill $swayidle_pid
			wait $swayidle_pid
			echo "No active SSH connection anymore. Swayidle will be restarted on next idle."
			unset swayidle_pid
		fi
		sleep 60
	fi
done
