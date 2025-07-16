{
  pkgs,
  user,
  ...
}: {
  imports = [
    ./hardware.nix
  ];
  users.users."${user}" = {
    name = "${user}";
    extraGroups = ["wheel" "networkmanager"];
    isNormalUser = true;
  };

  environment.systemPackages = with pkgs; [
    vim
  ];

  security.sudo.wheelNeedsPassword = false;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-b1a3bb26-bcd6-4a7b-8f02-077c12e90df9".device = "/dev/disk/by-uuid/b1a3bb26-bcd6-4a7b-8f02-077c12e90df9";

  networking.hostName = "asgard";

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  nixpkgs.config.allowUnfree = true;

  services.openssh.enable = true;

  system.stateVersion = "25.05";
}
