{ config, lib, ... }:
with lib;
let
  cfg = config.rui.syncthing;
in {
  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      user = "rui";
      group = "rui";
      dataDir = "/home/rui/Syncthing";
    };
  };
}
