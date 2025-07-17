#!/usr/bin/env bash

get_pacman_updates() {
	if command -v yay &>/dev/null; then
		updates=$(yay -Qu 2>/dev/null | wc -l)
		echo "$updates"
	else
		echo "0"
	fi
}

get_nix_updates() {
	if command -v nix &>/dev/null; then
		# Dry build of system with flake, fallback to legacy if needed
		updates=$(nix flake update --quiet &>/dev/null &&
			nixos-rebuild dry-activate --flake .# 2>/dev/null |
			grep -c 'will be built' || echo "0")
		echo "$updates"
	else
		echo "0"
	fi
}

get_flatpak_updates() {
	if command -v flatpak &>/dev/null; then
		updates=$(flatpak remote-ls --updates --app 2>/dev/null | wc -l)
		echo "$updates"
	else
		echo "0"
	fi
}

pacman=$(get_pacman_updates)
nix=$(get_nix_updates)
flatpak=$(get_flatpak_updates)
total=$((pacman + nix + flatpak))

output=$(printf '{ "text": "󰏕 %s" }' "$total")

echo "$output"
