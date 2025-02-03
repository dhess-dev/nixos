{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.dhess.foo;
in {
  options.dhess.foo = {
    enable = lib.mkEnableOption "Enable foo";
  };

  config = lib.mkIf cfg.enable {
    # some config
  };
}