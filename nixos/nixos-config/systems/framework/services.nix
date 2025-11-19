{ pkgs, ... }:

{
  services = {
    power-profiles-daemon.enable = true;

    xserver.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;

    blueman.enable = true;

    dbus.packages = [
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal
    ];
  };

  security.pam.services = {
    sddm.enableKwallet = true;
    rui.kwallet.enable = true;
  };

  xdg.portal = {
    enable = true;
    config.common.default-portal = "kde";
    extraPortals = [
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal
    ];
  };

  virtualisation.vmware.host.enable = true;
}
