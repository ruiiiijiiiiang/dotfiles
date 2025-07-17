{ ... }:

let
  username = "rui";
  homePath = "/home/${username}";
  flakePath = "${homePath}/nixos-config";
in {
  imports = [
    ./configs.nix
    ./services
  ];

  home.username = username;
  home.homeDirectory = homePath;
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
  programs.nh = {
    enable = true;
    flake = flakePath;
    clean = {
      enable = true;
      dates = "weekly";
    };
  };

  home.file.".config/autostart/nm-applet.desktop".text = ''
    [Desktop Entry]
    Name=NetworkManager Applet
    Comment=Manage your network connections
    Icon=nm-device-wireless
    Exec=nm-applet
    Terminal=false
    Type=Application
    NoDisplay=true
    NotShowIn=KDE;GNOME;
    X-GNOME-UsesNotifications=true
    Hidden=true
  '';
}
