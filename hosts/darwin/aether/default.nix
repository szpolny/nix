{
  inputs,
  pkgs,
  user,
  ...
}:
{
  users.users."${user}" = {
    name = "${user}";
    home = "/Users/${user}";
  };

  environment.systemPackages = with pkgs; [
    neovim
    tmux
    kitty
    nixfmt-rfc-style
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
    extraSpecialArgs = { inherit inputs pkgs user; };
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
    ];
    brews = [
      "gh"
    ];
    onActivation.cleanup = "zap";
  };

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
}
