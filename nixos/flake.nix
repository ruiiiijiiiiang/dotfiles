{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-staging.url = "github:NixOS/nixpkgs/staging";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay?rev=1b82dbcbbcba812ad19f5c0601d1731731bf4ebe";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.rui-nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        inputs.nixos-hardware.nixosModules.microsoft-surface-pro-intel
        # inputs.home-manager.nixosModules.default
        ({ config, pkgs, ... }: {
          nixpkgs.config.allowUnfree = true;
          nixpkgs.overlays = [
            inputs.neovim-nightly-overlay.overlays.default
            (final: prev: {
              staging = import inputs.nixpkgs-staging {
                system = prev.system;
                config.allowUnfree = true;
              };
              unstable = import inputs.nixpkgs-unstable {
                system = prev.system;
                config.allowUnfree = true;
              };
            })
          ];
          environment.systemPackages = with pkgs; [
            neovim
            unstable.niri
            unstable.wezterm
            unstable.starship
            unstable.yazi
            unstable.fzf
            unstable.codeium
            unstable.helix
          ];
        })
      ];
    };
  };
}
