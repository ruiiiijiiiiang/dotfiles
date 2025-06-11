{ config, pkgs, ... }:

{
  catppuccin = {
    enable = true;
    flavor = "frappe";
    accent = "lavender";
    sddm = {
      font = "Maple Mono";
      fontSize = "12";
      loginBackground = true;
      background = "/home/rui/Pictures/wallpaper.png";
    };
  };
}
