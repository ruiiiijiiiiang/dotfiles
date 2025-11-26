{ pkgs, ... }:

{
  rui = {
    acme.enable = true;
    atuin.enable = true;
    nginx.enable = true;
    homeassistant.enable = true;
    syncthing.enable = true;
  };

  services = {
    logrotate.enable = true;
  };
}
