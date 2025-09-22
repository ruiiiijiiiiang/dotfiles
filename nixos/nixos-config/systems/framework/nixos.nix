{ pkgs, ... }:

{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  systemd.user.services.flake-update = {
    unitConfig = {
      Description = "Update Nix flakes automatically";
    };
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.nix}/bin/nix flake update --flake /home/rui/nixos-config";
      WorkingDirectory = "/home/rui/nixos-config";
    };
    wantedBy = [ "default.target" ];
  };

  systemd.user.timers.flake-update = {
    unitConfig = {
      Description = "Run flake-update daily";
    };
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      Unit = "flake-update.service";
    };
    wantedBy = [ "timers.target" ];
  };
}
