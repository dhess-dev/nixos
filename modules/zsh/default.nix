{
  config,
  lib,
  pkgs,
  systemConfig,
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
      "dhess" = {
        shell = pkgs.zsh;
      };
    };
  };
}
