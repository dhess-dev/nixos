{
  config,
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    userName = "dhess-dev";
    userEmail = "danielhess.dev@gmail.com";
    lfs.enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      core.autocrlf = false;
      credential.helper = "libsecret";
    };
  };
}