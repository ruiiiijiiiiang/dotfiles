{ lib, config, ... }:
with lib;
let
  cfg = config.rui;
in {
  imports = [
    ./acme
    ./atuin
    ./catppuccin
    ./flatpak
    ./homeassistant
    ./nginx
    ./syncthing

    ./devops
  ];

  options.rui = {
    acme = {
      enable = mkEnableOption "enable let's encrypt certificate for domain";
    };
    atuin = {
      enable = mkEnableOption "atuin server setup";
    };
    catppuccin = {
      enable = mkEnableOption "custom catppuccin theme setup";
    };
    flatpak = {
      enable = mkEnableOption "enable flatpak service and packages";
    };
    homeassistant = {
      enable = mkEnableOption "enable homeassistant with zwave server";
    };
    nginx = {
      enable = mkEnableOption "enable nginx as a reverse proxy";
    };
    syncthing = {
      enable = mkEnableOption "enable and configure syncthing service";
    };

    devops = {
      enable = mkEnableOption "enable devops tools";
    };
  };

  config.assertions = [
    {
      assertion = (cfg.atuin.enable || cfg.homeassistant.enable) -> cfg.nginx.enable;
      message = "Error: You have enabled a service that requires a proxy server, but 'rui.nginx.enable' is false.";
    }
  ];
}
