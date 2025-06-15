{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-flatpak, catppuccin, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      nixosConfigurations = {
        rui-nixos = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            ./systems/framework
            ./modules
            nix-flatpak.nixosModules.nix-flatpak
            catppuccin.nixosModules.catppuccin
          ];

          specialArgs = { inherit inputs; };
        };
      };

      homeConfigurations = {
        rui = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ./homes/rui
          ];
        };
      };
    };
}
