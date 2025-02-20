# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      # <nixos-hardware/microsoft/surface/surface-pro-intel>
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "rui-nixos"; # Define your hostname.
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  # services.displayManager.defaultSession = "niri";

  # Enable automatic login for the user.
  # services.displayManager.autoLogin.enable = true;
  # services.displayManager.autoLogin.user = "rui";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  hardware.bluetooth.enable = true;
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = false;
  services.blueman.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "caps:escape";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rui = {
    isNormalUser = true;
    description = "Rui Jiang";
    extraGroups = [ "networkmanager" "video" "wheel" "docker" ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # system tools
    linux-firmware
    gcc
    cmake
    gnumake
    wget
    wl-clipboard
    libnotify

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

    # kde desktop
    kdePackages.plasma-pa
    kdePackages.kate
    kdePackages.filelight
    kdePackages.yakuake
    kdePackages.kolourpaint
    kdePackages.plasma-mobile
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugin-kvantum
    catppuccin-kde
    maliit-keyboard

    # gui apps
    libreoffice-qt
    mission-center

    # cli
    bat
    fzf
    stow
    lsd
    fastfetch
    fd
    btop
    clipboard-jh
    silver-searcher
    zoxide
    unzip
    glow
    miller
    jq
    ripgrep
    gdb
    spicetify-cli
    superfile
    cmatrix
    pipes
    cbonsai
    cava
    tty-clock
    tldr
    delta
    spotify-player

    # web dev
    deno
    nodejs
    typescript-language-server
    svelte-language-server
    tailwindcss-language-server
    nodePackages.vscode-json-languageserver

    # rust
    rustup # use rustup to manager all rust tool chain
    # rustc
    # cargo
    # clippy
    # rust-analyzer

    # lua
    lua54Packages.luarocks
    stylua
    lua-language-server

    # other languages/tools
    bash-language-server
    nil
    go
    yaml-language-server
    lldb
    ruby_3_4
    python313
    taplo
    marksman
    imagemagick
  ];

  environment.variables = {
    EDITOR = "nvim";
    DEVICE = "Surface Pro 4";
    OS = "nixos";
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-monochrome-emoji
    google-fonts
    nerdfonts
    font-awesome
    material-design-icons
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  programs.git.enable = true;
  programs.fish.enable = true;
  programs.vim.enable = true;
  programs.lazygit.enable = true;
  programs.thefuck.enable = true;
  programs.niri.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  services.flatpak.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "rui" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
