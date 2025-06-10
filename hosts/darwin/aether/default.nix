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
    ];
    brews = [
      "gh"
      "weechat"
    ];
    onActivation.cleanup = "zap";
    masApps = {
      "1Password for Safari" = 1569813296;
    };
  };

  # System settings
  system.defaults = {
    dock.autohide = true;
    dock.persistent-apps = [
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
}
