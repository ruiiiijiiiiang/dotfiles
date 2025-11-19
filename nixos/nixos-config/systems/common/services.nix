{ pkgs, ... }:

{
  services = {
    xserver.xkb = {
      layout = "us";
      options = "caps:escape";
    };

    resolved.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
