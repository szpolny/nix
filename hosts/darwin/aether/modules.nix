let
  baseModulesPath = ../../../modules;

  modules = [
    "shells/zsh.nix"
    "git.nix"
    "kitty.nix"
    "neovim"
  ];

  imports = builtins.map (module: baseModulesPath + "/${module}") modules;
in {
  inherit imports;
}
