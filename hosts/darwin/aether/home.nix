{
  inputs,
  pkgs,
  user,
  mac-app-util,
  ...
}:
let
  homeDirectory = "/Users/${user}";
in
{
  home.username = user;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "24.11";

  home.packages = [
    pkgs.git
    pkgs.lazygit
    pkgs.zsh
    pkgs.starship
    pkgs.fzf
    pkgs.zoxide
    pkgs.kitty
    pkgs.nerd-fonts.geist-mono
  ];

  fonts.fontconfig.enable = true;

  imports = [
    ./modules.nix
  ];

  programs.home-manager.enable = true;

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';
  };

  programs.lazygit.enable = true;

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

}
