{ config, lib, ... }:
with lib;
let
  consts = import ../../lib/consts.nix;
  cfg = config.rui.homeassistant;
in with consts; {
  config = mkIf cfg.enable {
    virtualisation = {
      podman = {
        enable = true;
        dockerCompat = true;
        autoPrune.enable = true;
      };

      oci-containers = {
        backend = "podman";
        containers = {
          homeassistant = {
            image = "ghcr.io/home-assistant/home-assistant:stable";
            volumes = [ "/var/lib/home-assistant:/config" ];
            environment.TZ = timeZone;
            extraOptions = [ "--network=host" ];
          };

          zwave-js-ui = {
            image = "zwavejs/zwave-js-ui:latest";
            ports = [ "8091:8091" "3000:3000" ];
            volumes = [ "/var/lib/zwave-js-ui:/usr/src/app/store" ];
            extraOptions = [ "--device=/dev/serial/by-id/usb-Silicon_Labs_CP2102N_USB_to_UART_Bridge_Controller_80edec297b57ed1193f12ef21c62bc44-if00-port0:/dev/zwave" ];
          };
        };
      };
    };

    systemd.tmpfiles.rules = [
      "d /var/lib/home-assistant 0755 root root -"
      "d /var/lib/zwave-js-ui 0755 root root -"
    ];

    services = {
      nginx.virtualHosts."ha.${homeDomain}" = {
        useACMEHost = homeDomain;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:8123";
          proxyWebsockets = true;
        };
      };
    };
  };
}
