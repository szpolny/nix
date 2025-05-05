{
  nixpkgs,
  platform,
  ...
}:
{
  nixpkgs.hostPlatform = "${platform}";

  # Call for touchId instead of password, when sudo
  security.pam.services.sudo_local.touchIdAuth = true;
}
