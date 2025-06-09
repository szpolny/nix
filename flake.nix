{
  description = "My configuration for macOS and some other machines in future";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    # Zellij plugins
    zjstatus.url = "github:dj95/zjstatus";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    mac-app-util,
    nix-homebrew,
    zjstatus,
  }: let
    user = "szymon";
    platform = "aarch64-darwin";
  in {
    darwinConfigurations."aether" = nix-darwin.lib.darwinSystem {
      specialArgs = {
        inherit inputs user platform;
      };
      modules = [
        {
          nix.settings.experimental-features = "nix-command flakes";
          system.configurationRevision = self.rev or self.dirtyRev or null;
        }
        mac-app-util.darwinModules.default
        nix-homebrew.darwinModules.nix-homebrew
        home-manager.darwinModules.home-manager
        {
          home-manager.sharedModules = [
            mac-app-util.homeManagerModules.default
          ];
        }
        ./hosts/darwin
        ./hosts/darwin/aether
      ];
    };
  };
}
