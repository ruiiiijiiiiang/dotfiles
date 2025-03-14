#!/usr/bin/env bash

if [[ $OS == "arch" ]]; then
	kwalletd6 &
	waybar -c ~/.config/waybar/config-arch.jsonc &
	~/.config/niri/change-wallpaper.sh &
	protonmail-bridge --no-window &
elif [[ $OS == "nixos" ]]; then
	waybar -c ~/.config/waybar/config-nixos.jsonc &
	swaybg -i ~/Pictures/nixos-wallpaper-catppuccin-frappe.png -m fill &
	flatpak run ch.protonmail.protonmail-bridge --no-window &
fi
