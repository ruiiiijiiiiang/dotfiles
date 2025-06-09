#!/usr/bin/env bash

if [[ $OS == "arch" ]]; then
	kwalletd6 &
	waybar -c ~/.config/waybar/config-arch.jsonc &
	protonmail-bridge --no-window &
elif [[ $OS == "nixos" ]]; then
	waybar -c ~/.config/waybar/config-nixos.jsonc &
	flatpak run ch.protonmail.protonmail-bridge --no-window &
fi
