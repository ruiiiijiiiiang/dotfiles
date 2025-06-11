{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # --- Hardware & System Info ---
    pciutils
    usbutils
    hwinfo

    # --- System & Process Monitoring ---
    htop
    glances
    iotop
    lsof
    btop

    # --- Networking & Connectivity ---
    iw
    nmap
    dig
    mtr
    wget

    # --- Disk & Filesystem Utilities ---
    tree
    ncdu
    rsync
    dust
    wl-clipboard
    dysk

    # --- Development & General Utilities ---
    unzip
    unrar
    gzip     # For .gz archives (usually pre-installed)
    bzip2    # For .bz2 archives (usually pre-installed)
    xz       # For .xz archives (usually pre-installed)

    # --- Nix-Specific Tools (Highly Recommended for NixOS users!) ---
    cachix   # Helper for working with Nix binary caches (speeds up builds, allows sharing custom packages)
    direnv   # Automatically loads/unloads environment variables based on directory (great for project development)
    nh       # (Optional) A collection of helpful Nix commands for daily use (e.g., cleaner garbage collection)
    nix-index # (Optional) Allows you to quickly find which Nixpkgs package provides a specific command (e.g., 'nix-index <command>')
    nix-search-cli

    # system tools
    linux-firmware
    gcc
    gdb
    cmake
    gnumake
    easyeffects

    # niri desktop
    rofi-wayland
    swaybg
    swaynotificationcenter
    swayidle
    swaylock-effects
    waybar
    networkmanagerapplet
    catppuccin-cursors.frappeLavender
    xwayland-satellite
    brightnessctl
    libnotify
    blueman

    # kde desktop
    kdePackages.plasma-pa
    kdePackages.kate
    kdePackages.filelight
    kdePackages.yakuake
    kdePackages.kolourpaint
    catppuccin-kde

    # gui apps
    wezterm
    libreoffice-qt
    mission-center
    neohtop

    # tui apps
    fzf
    stow
    lsd
    fastfetch
    fd
    silver-searcher
    glow
    miller
    jq
    ripgrep
    spicetify-cli
    superfile
    tldr
    delta
    imagemagick
    helix
    atuin
    posting
    starship
    termscp
    ncspot

    # web dev
    deno
    nodejs
    typescript-language-server
    svelte-language-server
    tailwindcss-language-server
    vscode-langservers-extracted
    vscode-js-debug
    nodePackages.vscode-json-languageserver

    # rust
    rustup # use rustup to manager all rust tool chain

    # lua
    lua54Packages.luarocks
    stylua
    lua-language-server

    # other languages/tools
    codeium
    lldb
    bash-language-server
    shellcheck
    nil
    go
    yaml-language-server
    pyright
    lldb
    ruby_3_4
    python313
    taplo
    marksman

    #shits and giggles
    cmatrix
    pipes
    cbonsai
    cava
    tty-clock
  ];

  programs.git.enable = true;
  programs.vim.enable = true;
  programs.niri.enable = true;
  programs.fish.enable = true;
  programs.lazygit.enable = true;
  programs.pay-respects.enable = true;
  programs.firefox.enable = true;
  programs.steam.enable = true;
  programs.zoxide.enable = true;
  programs.yazi.enable = true;
  programs.wireshark.enable = true;
  programs.tcpdump.enable = true;
  programs.neovim.enable = true;
  programs.chromium.enable = true;
  programs.bat.enable = true;

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-monochrome-emoji
      google-fonts
      nerd-fonts.symbols-only
      maple-mono.truetype
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "maple-mono" ];
      };
    };
  };
}
