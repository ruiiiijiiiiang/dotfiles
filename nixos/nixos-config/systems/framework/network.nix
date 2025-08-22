{ lib, ... }:

{
  networking.hostName = "rui-nixos";
  networking.networkmanager.enable = true;
  networking.extraHosts = ''
    192.168.68.65 rui-arch
  '';

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.useDHCP = lib.mkDefault true;
}
