{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-staging.url = "github:NixOS/nixpkgs/staging";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    wezterm = {
      url = "github:wezterm/wezterm?dir=nix&rev=ee0c04e735fb94cb5119681f704fb7fa6731e713";
      inputs.nixpkg.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay?rev=1b82dbcbbcba812ad19f5c0601d1731731bf4ebe";

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
              wezterm = inputs.wezterm.packages.${prev.system}.default;
            })
          ];
          environment.systemPackages = with pkgs; [
            unstable.starship
            unstable.yazi
            unstable.codeium
            unstable.zed-editor
            wezterm
            neovim
          ];
        })
      ];
    };
  };
}
