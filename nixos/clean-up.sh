#!/usr/bin/env bash

# Check if script is run as root
if [ "$(id -u)" -ne 0 ]; then
	echo "This script must be run as root. Please use sudo."
	exit 1
fi

nix-collect-garbage -d
sudo nix-store --gc
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old
nix-env -p /nix/var/nix/profiles/system --list-generations
