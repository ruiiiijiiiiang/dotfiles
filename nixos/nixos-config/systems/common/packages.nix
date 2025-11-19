{ inputs, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # --- System Core & Essentials ---
    linux-firmware

    # --- Terminal Emulators ---
    wezterm

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
    systemctl-tui
    lazyjournal

    # --- Networking & Connectivity ---
    iw
    nmap
    dig
    mtr
    wget
    networkmanagerapplet
    nssTools
    rustscan

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
    carapace
    gh
    navi
    smassh
    onefetch
    inputs.file_clipper.packages.${pkgs.stdenv.system}.default
    inputs.lazynmap.packages.${pkgs.stdenv.system}.default
    inputs.doxx.packages.${pkgs.stdenv.system}.default

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

    # --- Nix-Specific Tools ---
    cachix
    direnv
    nix-index
    nix-search-cli
    nix-tree
  ];

  programs = {
    git.enable = true;
    vim.enable = true;
    fish.enable = true;
    lazygit.enable = true;
    htop.enable = true;
    pay-respects.enable = true;
    zoxide.enable = true;
    yazi.enable = true;
    tcpdump.enable = true;
    neovim.enable = true;
    bat.enable = true;
    direnv.enable = true;
  };
}
