{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userName = "dhess-dev";
    userEmail = "d.hess@human.de";
    lfs.enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      core.autocrlf = false;
      credential.helper = "libsecret";
      rerere.enabled = true;
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "/home/dhess/.ssh/id_ed25519";
    };
    difftastic.enable = true;
  };
}
