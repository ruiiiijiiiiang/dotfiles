{ config, pkgs, lib, ... }:
with lib;
let
  consts = import ../../lib/consts.nix;
  cfg = config.rui.atuin;
in with consts; {
  config = mkIf cfg.enable {
    services = {
      postgresql = {
        enable = true;
        package = pkgs.postgresql_14;
        ensureDatabases = [ "atuin" ];
        ensureUsers = [
          {
            name = "atuin";
            ensureDBOwnership = true;
          }
        ];
      };

      atuin = {
        enable = true;
        openFirewall = true;
        port = 8888;
        host = "0.0.0.0";
        maxHistoryLength = 100000;
        openRegistration = false;
        database = {
            createLocally = true;
            uri = "postgresql:///atuin?host=/run/postgresql";
        };
      };

      nginx.virtualHosts."atuin.${homeDomain}" = {
        useACMEHost = homeDomain;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:8888";
        };
      };
    };
  };
}
