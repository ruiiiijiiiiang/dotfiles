{ lib, pkgs, ... }:

let
  utils = import ../../../lib/utils.nix { inherit lib pkgs; };

  startXwaylandSatelliteScript = pkgs.writeShellScript "start-xwayland-satellite" ''
    #!/bin/bash

    ${utils.findBinaryFunctionString}
    XWAYLAND_SATELLITE_PATH=$(find_binary_path "xwayland-satellite") || exit 1

    echo "Starting xwayland-satellite from $XWAYLAND_SATELLITE_PATH on display :12..."
    exec "$XWAYLAND_SATELLITE_PATH" :12 # Needs to match the env var set by niri config
  '';
in {
  systemd.user.services.xwayland-satellite = {
    Unit = {
      Description = "Rootless Xwayland Integration";
      After = [ "niri.service" ];
    };
    Install = {
      WantedBy = [ "niri.service" ];
    };
    Service = {
      Type = "exec";
      ExecStart = "${startXwaylandSatelliteScript}";
      Restart = "on-failure";
    };
  };
}
