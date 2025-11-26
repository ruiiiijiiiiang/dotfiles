{ lib, ... }:
let
  keys = import ../../lib/keys.nix;
in {
  networking = {
    hostName = "rui-nixos-pi";
    networkmanager.enable = true;
    networkmanager.wifi.powersave = false;
    useDHCP = lib.mkDefault true;
    firewall = {
      allowedTCPPorts = [
        22
        80
        443
        22000
      ];
      allowedUDPPorts = [ 22000 21027 ];
    };
  };

  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
    fail2ban = {
      enable = true;
      maxretry = 5;
      bantime = "24h";
      ignoreIP = [
        "192.168.1.0/24"
      ];
    };
  };

  users.users.rui.openssh.authorizedKeys.keys = keys.ssh.rui-arch ++ keys.ssh.rui-nixos;
}
