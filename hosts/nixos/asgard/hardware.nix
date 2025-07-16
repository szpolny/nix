{
  config,
  lib,
  ...
}: {
  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/9c3b9a16-badc-4d16-a5a9-18f67619727a";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-4ecd55cd-6ddd-4186-ac24-8a731d8e530d".device = "/dev/disk/by-uuid/4ecd55cd-6ddd-4186-ac24-8a731d8e530d";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/04B8-5B45";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/811a98b6-57a8-48fa-8f86-5424d995fac7";}
  ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
