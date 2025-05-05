{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, mac-app-util, nix-homebrew }:
  let
    username = "szymon";

    configuration = { pkgs, ... }: {

      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ 
	  pkgs.neovim
	  pkgs.tmux
	  pkgs.kitty
	  pkgs.mkalias
        ];

      nix-homebrew = {
	enable = true;
	enableRosetta = true;
	user = "szymon";
	autoMigrate = true;
      };

      homebrew = {
      	enable = true;
	  casks = [
	    "1password"
	    "1password-cli"
	    "firefox"
	    "keka"
	    "discord"
	    "steam"
	    "visual-studio-code"
	  ];
	  brews = [
	    "gh"
	  ];
	  onActivation.cleanup = "zap";
      };



      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # Call for touchId instead of password, when sudo
      security.pam.services.sudo_local.touchIdAuth = true;

      # System settings
      system.defaults = {
      	dock.autohide = true;
	dock.persistent-apps = [
	  "${pkgs.kitty}/Applications/kitty.app"
	  "Applications/Firefox.app"
	  "System/Applications/Messages.app"
	  "System/Applications/Mail.app"
	  "System/Applications/Calendar.app"
	  "System/Applications/Music.app"	
	];
	dock.show-recents = false;
	loginwindow.GuestEnabled = false;
	NSGlobalDomain.AppleICUForce24HourTime = true;
	NSGlobalDomain.AppleInterfaceStyle = "Dark";
	NSGlobalDomain.AppleShowAllExtensions = true;
	NSGlobalDomain.InitialKeyRepeat = 25;
	NSGlobalDomain.KeyRepeat = 2;
	magicmouse.MouseButtonMode = "TwoButton";
	screencapture.location = "~/Pictures/screenshots";
      };

      home-manager = {
	useGlobalPkgs = true;
	useUserPackages = true;
	users.${username} = import ./home.nix;
	extraSpecialArgs = { inherit inputs username; };
	backupFileExtension = "bk";
      };

      users.users."${username}" = {
      	name = "${username}";
      	home = "/Users/${username}";
      };
   };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .
    darwinConfigurations."MacBook-Pro-Szymon" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
	mac-app-util.darwinModules.default
	nix-homebrew.darwinModules.nix-homebrew
	home-manager.darwinModules.home-manager
      ];
    };
  };
}
