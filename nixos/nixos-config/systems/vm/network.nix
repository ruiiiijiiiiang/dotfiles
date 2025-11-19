{ lib, ... }:

{
  networking = {
    hostName = "rui-nixos-vm";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };
}
