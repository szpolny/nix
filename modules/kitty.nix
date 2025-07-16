{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    font.name = "GeistMono Nerd Font Mono";
    font.package = pkgs.nerd-fonts.geist-mono;
    font.size = 14;
    themeFile = "OneDark-Pro";
    settings = {
      background_opacity = 0.9;
      background_blur = 64;
    };
  };
}
