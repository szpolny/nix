{config, ...}: {
  xdg.configFile = {
    "zellij/config.kdl" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/dotfiles/zellij/config.kdl";
    };
  };
}
