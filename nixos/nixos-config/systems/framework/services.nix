{ pkgs, ... }:

{
  services = {
    resolved.enable = true;

    power-profiles-daemon.enable = true;

    xserver.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;

    xserver.xkb = {
      layout = "us";
      options = "caps:escape";
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    blueman.enable = true;

    # protonmail-bridge = {
    #   enable = true;
    #   path = with pkgs; [
    #     kdePackages.kwallet
    #   ];
    #
    # };

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

  virtualisation = {
    vmware.host.enable = true;
  };
}
