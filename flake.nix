{
  description = "rui's dotfiles source flake";

  outputs = { self, ... }: {
    lib.source = self.outPath;
  };
}
