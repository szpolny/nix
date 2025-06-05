{
  programs.git = {
    enable = true;
    userName = "Szymon";
    userEmail = "szymonpolny@outlook.com";
    extraConfig = {
      core = {
        editor = "nvim";
      };
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
