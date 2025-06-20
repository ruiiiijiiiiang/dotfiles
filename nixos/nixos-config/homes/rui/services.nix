{ pkgs, ... }:

let
  startWaybarScript = pkgs.writeShellScript "start-warbay" ''
    #!/bin/bash

    # Define your config file path (default is ~/.config/waybar/config.json)
    CONFIG_FILE="$HOME/.config/waybar/config.json"
    if [[ $OS == "arch" ]]; then
      CONFIG_FILE="$HOME/.config/waybar/arch-config.json"
    elif [[ $OS == "nixos" ]]; then
      CONFIG_FILE="$HOME/.config/waybar/nixos-config.json"
    fi

    # Check for Waybar in common FHS paths
    if command -v waybar &>/dev/null; then
      WAYBAR_PATH=$(command -v waybar)
    elif [ -f "/usr/bin/waybar" ]; then
      WAYBAR_PATH="/usr/bin/waybar"
    elif [ -f "/usr/local/bin/waybar" ]; then
      WAYBAR_PATH="/usr/local/bin/waybar"
    # Check for NixOS path (or other specific paths)
    elif [ -f "/run/current-system/sw/bin/waybar" ]; then
      WAYBAR_PATH="/run/current-system/sw/bin/waybar"
    else
      echo "Error: Waybar executable not found!" >&2
      exit 1
    fi

    exec "$WAYBAR_PATH" -c "$CONFIG_FILE"
  '';

in {
  systemd.user.service.waybar = {
    enable = true;
    description = "Waybar status bar";
    after = [ "niri.service" ];
    wantedBy = [ "niri.service" ];
    serviceConfig = {
      Type = "exec";
      ExecStart = "${startWaybarScript}";
      Restart = "on-failure";
      TimeoutStopSec = 5;
    };
  };
}
