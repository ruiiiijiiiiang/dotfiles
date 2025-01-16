# { config, pkgs, pkgs-unstable, ... }:
# let
  # isNixOS = builtins.pathExists /etc/nixos;
# in
{
  home.username = "rui";
  home.homeDirectory = "/home/rui";
  home.stateVersion = "23.11";
  home.enableNixpkgsReleaseCheck = false;

  programs = {
    home-manager.enable = true;
    starship.enable = true;
    lazygit.enable = true;
    fastfetch.enable = true;
  };

  xdg.enable = true;

  xdg.configFile = {
    "starship.toml".source = ./configs/starship.toml;
    "lazygit/config.yml".source = ./configs/lazygit/config.yml;
    "fastfetch/config.jsonc".source = ./configs/fastfetch/config.jsonc;
  };
}
