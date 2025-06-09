{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    user = "rui";
    group = "rui";
    dataDir = "/home/rui/Syncthing";
  };
}
