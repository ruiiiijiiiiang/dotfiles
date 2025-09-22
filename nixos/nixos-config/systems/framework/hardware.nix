{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "thunderbolt"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [
    "amdgpu"
    "mt7921e"
  ];
  boot.kernelModules = [
    "mt7921e"
  ];
  boot.blacklistedKernelModules = [
    "kvm-amd" # "kvm-amd" conflicts with virtualbox
  ];
  boot.extraModulePackages = [ ];

  boot.kernelParams = [
    "quiet"
    "splash"
    "resume=UUID=e01c20a2-fff9-4685-ab9d-1c20da55f6a0"
  ];

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/7279-99D8";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/e1da5afa-cc18-4576-be7d-4edb5f93d857";
    fsType = "btrfs";
    options = [
      "noatime"
      "compress=zstd"
      "ssd"
      "subvol=@"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/e1da5afa-cc18-4576-be7d-4edb5f93d857";
    fsType = "btrfs";
    options = [
      "noatime"
      "compress=zstd"
      "ssd"
      "subvol=@home"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/e1da5afa-cc18-4576-be7d-4edb5f93d857";
    fsType = "btrfs";
    options = [
      "noatime"
      "compress=zstd"
      "ssd"
      "subvol=@nix"
    ];
  };

  fileSystems."/tmp" = {
    device = "/dev/disk/by-uuid/e1da5afa-cc18-4576-be7d-4edb5f93d857";
    fsType = "btrfs";
    options = [
      "noatime"
      "compress=zstd"
      "ssd"
      "subvol=@tmp"
      "nodatacow"
    ];
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/e1da5afa-cc18-4576-be7d-4edb5f93d857";
    fsType = "btrfs";
    options = [
      "noatime"
      "compress=zstd"
      "ssd"
      "subvol=@log"
      "nodatacow"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/e01c20a2-fff9-4685-ab9d-1c20da55f6a0"; }
  ];

  zramSwap.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth.enable = true;

  services.fstrim.enable = true;
  services.fwupd.enable = true;
}
