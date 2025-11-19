{ lib, ... }:

{
  imports = [
    ../common/nixos.nix
    ../common/services.nix
    ../common/packages.nix
    ../common/users.nix
    ./hardware.nix
    ./network.nix
    ./services.nix
    ./users.nix
  ];

  # Disable flatpak for VM
  services.flatpak.enable = lib.mkForce false;

  environment.variables = {
    OS = "nixos";
    EDITOR = "nvim";
    NH_FLAKE = "/home/rui/nixos-config/";
  };

  system.stateVersion = "25.11";
}
