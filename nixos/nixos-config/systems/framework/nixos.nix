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

  systemd.user.services."flake-update" = {
    Unit = {
      Description = "Update Nix flakes automatically";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.nix}/bin/nix flake update /home/rui/nixos-config";
      WorkingDirectory = "/home/rui/nixos-config";
    };
  };

  systemd.user.timers."flake-update" = {
    Unit = {
      Description = "Run flake-update weekly";
    };
    Timer = {
      OnCalendar = "weekly";
      Persistent = true;
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
