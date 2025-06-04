{
  platform,
  user,
  ...
}: {
  nixpkgs.hostPlatform = "${platform}";

  system.primaryUser = user;

  # Call for touchId instead of password, when sudo
  security.pam.services.sudo_local.touchIdAuth = true;
}
