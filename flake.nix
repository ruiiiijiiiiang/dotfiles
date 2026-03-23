{
  description = "Personal dotfiles source flake";

  outputs =
    { self, ... }:
    {
      lib.source = self.outPath;
    };
}
