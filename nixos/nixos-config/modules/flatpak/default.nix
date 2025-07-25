{ ... }:

{
  services.flatpak.enable = true;

  services.flatpak.remotes = [
    {
      name = "flathub";
      location = "https://flathub.org/repo/flathub.flatpakrepo";
    }
  ];

  # Optional: Auto-update
  services.flatpak.update.auto.enable = true;
  services.flatpak.update.auto.onCalendar = "weekly";

  services.flatpak.packages = [
    "app.zen_browser.zen"
    "eu.betterbird.Betterbird"
    "io.github.milkshiift.GoofCord"
    "com.spotify.Client"
    "org.upscayl.Upscayl"
  ];
}
