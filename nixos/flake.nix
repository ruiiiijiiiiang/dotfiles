{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-staging.url = "github:NixOS/nixpkgs/staging";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, nixpkgs-staging, nixpkgs-unstable, nixos-hardware, ... }@inputs: {
    nixosConfigurations.rui-nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        nixos-hardware.nixosModules.microsoft-surface-pro-intel
        # inputs.home-manager.nixosModules.default
        ({ config, pkgs, ... }: {
          nixpkgs.config.allowUnfree = true;
          nixpkgs.overlays = [
            (final: prev: {
              staging = import nixpkgs-staging {
                system = prev.system;
                config.allowUnfree = true;
              };
              unstable = import nixpkgs-unstable {
                system = prev.system;
                config.allowUnfree = true;
              };
            })
          ];
          environment.systemPackages = with pkgs; [
            unstable.starship
            unstable.yazi
            unstable.codeium
            unstable.zed-editor
          ];
        })
      ];
    };
  };
}
