{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    initrd.availableKernelModules = [
      "ata_piix"
      "mptspi"
      "uhci_hcd"
      "ehci_pci"
      "sd_mod"
      "sr_mod"
      "virtio"
      "virtio_pci"
      "virtio_ring"
      "virtio_blk"
      "virtio_net"
      "vmwgfx"
      "vmmouse"
      "hv_vmbus"
      "hv_storvsc"
      "hv_netvsc"
    ];
    initrd.kernelModules = [ ];
    kernelModules = [ ];
    extraModulePackages = [ ];
  };

  virtualisation.vmware.guest.enable = true;
  services.open-vm-tools.enable = true;

  fileSystems = {
    "/" = {
      device = "LABEL=nixos";
      fsType = "ext4";
    };
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.enableRedistributableFirmware = true;
}
