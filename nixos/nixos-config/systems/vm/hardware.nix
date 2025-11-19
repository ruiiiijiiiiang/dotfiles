{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  boot = {
    loader.grub.enable = true;
    loader.grub.device = "/dev/sda";
    
    initrd.availableKernelModules = [
      "ata_piix"
      "mptspi"
      "uhci_hcd"
      "ehci_pci"
      "sd_mod"
      "sr_mod"
    ];
    initrd.kernelModules = [ ];
    kernelModules = [ ];
    extraModulePackages = [ ];
  };

  # VMware guest tools
  virtualisation.vmware.guest.enable = true;

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.enableRedistributableFirmware = true;
}
