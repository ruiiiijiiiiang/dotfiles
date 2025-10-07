{ ... }:

let
  username = "rui";
  homePath = "/home/${username}";
  flakePath = "${homePath}/nixos-config";
in
{
  imports = [
    ./configs.nix
    ./files
    ./services
  ];

  home.username = username;
  home.homeDirectory = homePath;
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
  programs.nh = {
    enable = true;
    flake = flakePath;
    clean = {
      enable = true;
      dates = "weekly";
    };
  };
}
