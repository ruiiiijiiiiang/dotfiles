{ config, ... }:

{
  imports = [
    ./configs.nix
    ./services.nix
  ];

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
  programs.nh = {
    enable = true;
    flake = "${config.home.homeDirectory}/nixos-config";
    clean = {
      enable = true;
      dates = "weekly";
    };
  };
}
