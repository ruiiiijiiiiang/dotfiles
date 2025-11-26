{ config, lib, inputs, ... }:
with lib;
let
  keys = import ../../lib/keys.nix;
  consts = import ../../lib/consts.nix;
in with keys; with consts; {
  age.secrets = {
    wg-privatekey.file = ../../secrets/wg-privatekey.age;
    wg-presharedkey.file = ../../secrets/wg-presharedkey.age;
  };

  networking = {
    hostName = "rui-nixos";
    networkmanager.enable = true;
    useDHCP = mkDefault true;

    wg-quick.interfaces.wg-home = {
      privateKeyFile = config.age.secrets.wg-privatekey.path;
      address = [ "10.5.5.4/32" ];
      peers = [
        {
          inherit (wg.wg-home) publicKey;
          presharedKeyFile = config.age.secrets.wg-presharedkey.path;
          endpoint = "${tplinkDomain}:${wgPort}";
          allowedIPs = [ "192.168.68.0/24" ];
          persistentKeepalive = 60;
        }
      ];
    };
  };
}
