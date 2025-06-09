{
  config,
  pkgs,
  ...
}: {
  xdg.configFile = {
    "zellij/config.kdl" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/dotfiles/zellij/config.kdl";
    };
    "zellij/layouts/default.kdl" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/dotfiles/zellij/layouts/default.kdl";
    };
    "zellij/plugins/zjstatus.wasm" = {
      source = "${pkgs.zjstatus}/bin/zjstatus.wasm";
    };
    "zellij/plugins/zellij-autolock.wasm" = {
      source = "${pkgs.zellij-autolock}/bin/zellij-autolock.wasm";
    };
  };
}
