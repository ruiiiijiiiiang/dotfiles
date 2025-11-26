{ pkgs, ... }:

{
  services = {
    xserver.xkb = {
      layout = "us";
      options = "caps:escape";
    };

    resolved.enable = true;
  };
}
