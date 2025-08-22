{ config, ... }:

let
  dotfilesPath = "${config.home.homeDirectory}/dotfiles";
in {
  home.file = {
    ".config/atuin".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/atuin/.config/atuin";

    ".config/delta".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/delta/.config/delta";

    ".config/bat".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/bat/.config/bat";

    ".config/bottom".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/bottom/.config/bottom";

    ".config/btop".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/btop/.config/btop";

    ".config/fastfetch".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/fastfetch/.config/fastfetch";

    ".config/fish".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/fish/.config/fish";

    ".gitconfig".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/git/.gitconfig";

    ".config/lazygit".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/lazygit/.config/lazygit";

    ".config/lsd".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/lsd/.config/lsd";

    ".config/ncspot".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/ncspot/.config/ncspot";

    ".config/niri".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/niri/.config/niri";

    ".config/niriswitcher".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/niriswitcher/.config/niriswitcher";

    "nixos-config".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/nixos/nixos-config";

    ".noxdir".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/noxdir/.noxdir";

    ".config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/nvim/.config/nvim";

    ".config/posting".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/posting/.config/posting";
    ".local/share/posting/themes".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/posting/.local/share/posting/themes";

    ".config/rofi".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/rofi/.config/rofi";

    ".config/spicetify/Themes/text".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/spicetify/.config/spicetify/Themes/text";

    ".config/starship.toml".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/starship/.config/starship.toml";

    ".config/superfile".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/superfile/.config/superfile";

    ".config/swaylock".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/swaylock/.config/swaylock";

    ".config/swaync".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/swaync/.config/swaync";

    ".config/swayosd".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/swayosd/.config/swayosd";

    ".config/waybar".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/waybar/.config/waybar";

    ".config/wezterm".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/wezterm/.config/wezterm";

    ".config/yazi".source =
      config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/yazi/.config/yazi";
  };
}
