let
  baseModulesPath = ../../../modules;

  modules = [
    "shells/zsh.nix"
    "git.nix"
    "kitty.nix"
    "neovim"
    "zellij.nix"
  ];

  imports = builtins.map (module: baseModulesPath + "/${module}") modules;
in {
  inherit imports;
}
