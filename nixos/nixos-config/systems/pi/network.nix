{ lib, ... }:
with lib;
let
  consts = import ../../lib/consts.nix;
  keys = import ../../lib/keys.nix;
in with consts; with keys; {
  networking = {
    hostName = "rui-nixos-pi";
    networkmanager = {
      wifi.powersave = false;
    };
    firewall = {
      allowedTCPPorts = [ 22 80 443 ports.homeassistant ];
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
      ignoreIP = [ addresses.home.network ];
    };
  };

  users.users.rui.openssh.authorizedKeys.keys = ssh.rui-arch ++ ssh.rui-nixos;
}
