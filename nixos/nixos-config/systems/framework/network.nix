{ lib, ... }:

{
  networking = {
    hostName = "rui-nixos";
    networkmanager.enable = true;
    extraHosts = ''
      192.168.68.65 rui-arch
    '';
    useDHCP = lib.mkDefault true;
  };
}
