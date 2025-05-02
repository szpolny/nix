{ config, pkgs, username, ... }:
let
  homeDirectory = "/Users/${username}";
in
{
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "24.11";
    
  home.packages = [
    pkgs.git
  ];

  programs.home-manager.enable = true;
  
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';
  };

  programs.git = {
    enable = true;
    userName = "Szymon";
    userEmail = "szymonpolny@outlook.com";
    extraConfig = {
      gpg = {
        format = "ssh";
      };
      "gpg \"ssh\"" = {
	program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      };
      commit.gpgsign = true;
      user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIELZsezGmVU4yBlMxwrN1OCmsbarL1tdJ+72sy/y4kTz";
    };
  };
}
