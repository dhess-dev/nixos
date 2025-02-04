{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.dhess.docker;
in {
  options.dhess.docker = {
    enable = lib.mkEnableOption "Enable Docker";
  };

  config = lib.mkIf cfg.enable {
    # Hard-code "dhess" as the username here:
    users.users.dhess.extraGroups = ["docker"];

    virtualisation.docker = {
      enable = true;
      daemon.settings = {
        # Example mirror
        "registry-mirrors" = ["https://mirror.gcr.io"];

        # Example custom address pools
        "bip" = "192.168.180.1/24";
        "default-address-pools" = [
          {
            base = "192.168.181.0/24";
            size = 24;
          }
          {
            base = "192.168.182.0/24";
            size = 24;
          }
          # etc...
        ];
      };
    };
  };
}
