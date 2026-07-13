{
  description = "Personal dotfiles source flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      lib.source = builtins.path {
        name = "dotfiles-source";
        path = self;
        filter =
          path: type:
          let
            base = baseNameOf path;
          in
          !(type == "directory" && (base == "screenshots" || base == ".git" || base == ".stfolder"));
      };

      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          # Nix
          nil
          nixfmt

          # Lua
          lua-language-server
          stylua

          # TOML
          taplo

          # Shell
          shellcheck
          shfmt

          # YAML
          yaml-language-server
        ];
      };
    };
}
