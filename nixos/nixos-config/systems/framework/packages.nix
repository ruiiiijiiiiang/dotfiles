{ inputs, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "libxml2-2.13.8" # Required for PacketTracer
  ];

  environment.systemPackages = with pkgs; [
    # --- System Core & Essentials ---
    linux-firmware

    # --- System Information & Diagnostics ---
    pciutils
    usbutils
    hwinfo
    fastfetch
    kmon

    # --- System & Process Monitoring ---
    sysstat
    btop
    bottom
    htop
    neohtop
    glances
    iotop
    lsof
    mission-center
    systemctl-tui
    lazyjournal

    # --- Networking & Connectivity ---
    iw
    nmap
    dig
    mtr
    wget
    networkmanagerapplet

    # --- Disk & Filesystem Utilities ---
    tree
    ncdu
    rsync
    dust
    dysk
    inputs.noxdir.packages.${pkgs.stdenv.system}.default

    # --- Archiving & Compression ---
    unzip
    unrar
    ouch

    # --- General CLI Tools ---
    stow
    tldr
    starship
    atuin
    gnupg
    posting
    imagemagick
    pastel
    superfile
    broot
    xplr
    inputs.file-clipper.packages.${pkgs.stdenv.system}.default

    # --- File & Text Search/Manipulation CLI Tools ---
    fzf
    lsd
    fd
    silver-searcher
    ripgrep
    jq
    yq
    miller
    delta
    glow
    binsider
    fx
    helix

    # --- Terminal Emulators ---
    wezterm

    # --- GUI Applications ---
    vivaldi
    zed-editor
    libreoffice-qt
    kdePackages.kate
    kdePackages.filelight
    kdePackages.kolourpaint
    kdePackages.yakuake
    kdePackages.qtdeclarative
    ungoogled-chromium
    sniffnet
    yaak
    ciscoPacketTracer8
    wireshark

    # --- Desktop Environment: Niri (Wayland) ---
    libnotify
    rofi-wayland
    niriswitcher
    swaybg
    swaynotificationcenter
    swayidle
    swaylock-effects
    swayosd
    waybar
    brightnessctl
    pavucontrol
    xwayland-satellite
    catppuccin-cursors.frappeLavender
    wl-clipboard

    # --- Desktop Environment: KDE Plasma (Core & Theming) ---
    kdePackages.plasma-pa
    catppuccin-kde

    # --- Audio & Multimedia ---
    easyeffects
    ncspot
    spicetify-cli
    cava

    # --- Development Tools: Compilers, Debuggers, Build Systems ---
    gcc
    gdb
    lldb
    cmake
    gnumake

    # --- Development Tools: Language Tooling ---
    # Web Development
    deno
    nodejs
    typescript-language-server
    svelte-language-server
    tailwindcss-language-server
    vscode-langservers-extracted
    vscode-js-debug
    vtsls
    nodePackages.vscode-json-languageserver
    nodePackages.prettier

    # Rust
    rustup

    # Lua
    lua54Packages.luarocks
    stylua
    lua-language-server

    # Python
    python313
    pyright
    ruff
    python313Packages.debugpy

    # Go
    go

    # Ruby
    ruby_3_4

    # Nix
    nil

    # Shell Scripting
    bash-language-server
    shellcheck
    shfmt

    # Other Languages/Tools
    codeium
    yaml-language-server
    taplo
    marksman
    markdownlint-cli2

    # --- Nix-Specific Tools ---
    cachix
    direnv
    nix-index
    nix-search-cli
    nix-tree

    # --- Fun & Entertainment ---
    cmatrix
    cbonsai
    tty-clock
    astroterm
    pipes
  ];

  programs.git.enable = true;
  programs.vim.enable = true;
  programs.niri.enable = true;
  programs.fish.enable = true;
  programs.lazygit.enable = true;
  programs.htop.enable = true;
  programs.pay-respects.enable = true;
  programs.firefox.enable = true;
  programs.steam.enable = true;
  programs.zoxide.enable = true;
  programs.yazi.enable = true;
  programs.wireshark.enable = true;
  programs.tcpdump.enable = true;
  programs.neovim.enable = true;
  programs.bat.enable = true;
  programs.direnv.enable = true;

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
