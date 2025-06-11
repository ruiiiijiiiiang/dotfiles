#!/usr/bin/env bash

if [[ $OS == "arch" ]]; then
	waybar -c ~/.config/waybar/config-arch.jsonc &
	kwalletd6 &
	protonmail-bridge --no-window &
elif [[ $OS == "nixos" ]]; then
	waybar -c ~/.config/waybar/config-nixos.jsonc &
	flatpak run ch.protonmail.protonmail-bridge --no-window &
fi
