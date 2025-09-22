{ pkgs, ... }:

{
  services.resolved.enable = true;

  services.power-profiles-daemon.enable = true;

  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;

  security.pam.services = {
    sddm.enableKwallet = true;
    rui.kwallet.enable = true;
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  services.xserver.xkb = {
    layout = "us";
    options = "caps:escape";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.blueman.enable = true;

  services.protonmail-bridge = {
    enable = true;
    path = with pkgs; [
      kdePackages.kwallet
    ];

  };

  services.dbus.packages = [
    pkgs.kdePackages.xdg-desktop-portal-kde
    pkgs.xdg-desktop-portal
  ];
  xdg.portal = {
    enable = true;
    config.common.default-portal = "kde";
    extraPortals = [
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal
    ];
  };

  virtualisation = {
    virtualbox.host.enable = true;
    vmware.host.enable = true;
  };
}
