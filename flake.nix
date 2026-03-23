{
  description = "Personal dotfiles source flake";

  outputs =
    { self, ... }:
    {
      lib.source = builtins.path {
        name = "dotfiles-source";
        path = self;
        filter = path: type:
          let
            base = baseNameOf path;
          in
            !(type == "directory" && (base == "screenshots" || base == ".git" || base == ".stfolder"));
      };
    };
}
