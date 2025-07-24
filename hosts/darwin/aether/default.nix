{
  inputs,
  pkgs,
  user,
  ...
}: {
  users.users."${user}" = {
    name = "${user}";
    home = "/Users/${user}";
  };

  nixpkgs.overlays = [
    (final: prev: {
      zjstatus = inputs.zjstatus.packages.${prev.system}.default;
    })
    (final: prev: {
      zellij-autolock = final.callPackage ./../../../pkgs/zellij-autolock.nix {};
    })
  ];

  environment.systemPackages = with pkgs; [
    neovim
    tmux
    nixfmt-rfc-style
    neofetch
    rustc
    rustup
    nodejs
    nixd
    ripgrep
    lynx
    luarocks
    wget
    tree-sitter
    fd
    tree
    zellij
    zellij-autolock
    deploy-rs
  ];

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    user = "${user}";
    autoMigrate = true;
  };

  system.stateVersion = 6;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.${user} = import ./home.nix;
    extraSpecialArgs = {inherit inputs pkgs user;};
    backupFileExtension = "bk";
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
      "iina"
      "pearcleaner"
      "google-chrome"
      "dotnet-sdk"
      "godot-mono"
      "mullvad-vpn"
    ];
    brews = [
      "gh"
      "weechat"
      "deno"
      "pnpm"
      "yarn"
      "bat"
    ];
    onActivation.cleanup = "zap";
    masApps = {
      "1Password for Safari" = 1569813296;
      "AdGuard for Safari" = 1440147259;
      "Xcode" = 497799835;
      "Userscripts" = 1463298887;
    };
  };

  # System settings
  system.defaults = {
    dock.autohide = true;
    dock.show-recents = false;
    loginwindow.GuestEnabled = false;
    NSGlobalDomain.AppleICUForce24HourTime = true;
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.InitialKeyRepeat = 25;
    NSGlobalDomain.KeyRepeat = 2;
    magicmouse.MouseButtonMode = "TwoButton";
    screencapture.location = "~/Pictures/screenshots";
    CustomUserPreferences = {
      "com.apple.symbolichotkeys" = {
        AppleSymbolicHotKeys = {
          "60" = {
            enabled = false;
          };
        };
      };
    };
  };

  system.activationScripts.postActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle when changing settings
    sudo -u szymon /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
