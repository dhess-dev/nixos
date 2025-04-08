{
  config,
  lib,
  pkgs,
  defaultConfig,
  ...
}: let
  cfg = config.dhess.zsh;
in {
  options.dhess.zsh = {
    enable = lib.mkEnableOption "Enable zsh";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh.enable = true;

    # make completions work
    environment.pathsToLink = ["/share/zsh"];

    users.users = {
      ${defaultConfig.user.username} = {
        shell = pkgs.zsh;
      };
    };
  };
}
