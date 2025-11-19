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

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    file_clipper.url = "github:ruiiiijiiiiang/file_clipper";
    lazynmap.url = "github:ruiiiijiiiiang/lazynmap";
    noxdir.url = "github:crumbyte/noxdir";
    doxx.url = "github:bgreenwell/doxx";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-flatpak,
      catppuccin,
      ...
    }@inputs:
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

        rui-nixos-vm = nixpkgs.lib.nixosSystem {
          inherit system;

          modules = [
            ./systems/vm
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

        rui-vm = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ./homes/vm
          ];
        };
      };
    };
}
