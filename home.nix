{
  config,
  pkgs,
  username,
  ...
}:
let
  homeDirectory = "/Users/${username}";
in
{
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "24.11";

  home.packages = [
    pkgs.git
    pkgs.lazygit
    pkgs.zsh
    pkgs.starship
    pkgs.fzf
    pkgs.zoxide
  ];

  programs.home-manager.enable = true;

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';
  };

  programs.lazygit.enable = true;

  programs.starship = {
    enable = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    history.size = 10000;
    history.save = 10000;
    history.ignoreDups = true;
    history.ignoreAllDups = true;
    history.saveNoDups = true;
    history.findNoDups = true;
    history.share = true;
    history.append = true;
    history.path = "$HOME/.zsh_history";
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-syntax-highlighting"; }
        { name = "zsh-users/zsh-completions"; }
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-history-substring-search"; }
        { name = "Aloxaf/fzf-tab"; }
      ];
    };

    shellAliases = {
      reload = "source ~/.zshrc";
      ls = "ls --color";
      mkdir = "mkdir -p";
    };

    initContent = ''
      bindkey '^B' autosuggest-toggle

      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down

      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

      bindkey -e
    '';
  };

  programs.git = {
    enable = true;
    userName = "Szymon";
    userEmail = "szymonpolny@outlook.com";
    extraConfig = {
      gpg = {
        format = "ssh";
      };
      "gpg \"ssh\"" = {
        program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      };
      commit.gpgsign = true;
      user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIELZsezGmVU4yBlMxwrN1OCmsbarL1tdJ+72sy/y4kTz";
    };
  };
}
