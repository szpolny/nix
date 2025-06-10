{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    font.name = "GeistMono Nerd Font Mono";
    font.package = pkgs.nerd-fonts.geist-mono;
    font.size = 14;
    themeFile = "Github_Dark";
  };
}
