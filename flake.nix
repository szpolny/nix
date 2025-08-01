{
  description = "My configuration for macOS and some other machines in future";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    opnix.url = "github:brizzbuzz/opnix";

    deploy-rs.url = "github:serokell/deploy-rs";

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
    opnix,
    deploy-rs,
    nix-darwin,
    home-manager,
    mac-app-util,
    nix-homebrew,
    zjstatus,
  }: let
    user = "szymon";
    platform = "aarch64-darwin";
  in {
    nixosConfigurations."asgard" = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs user;
      };
      system = "x86_64-linux";
      modules = [
        opnix.nixosModules.default
        ./hosts/nixos/asgard
      ];
    };

    deploy.nodes."asgard" = {
      hostname = "asgard";
      profiles.system = {
        user = "root";
        sshUser = "szymon";
        remoteBuild = true;
        path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.asgard;
      };
    };

    checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;

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
