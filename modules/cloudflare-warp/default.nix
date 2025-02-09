{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dhess.cloudflare-warp;
in {
  options.dhess.cloudflare-warp = {
    enable = lib.mkEnableOption "Enable Cloudflare Warp Client";
  };

  config = lib.mkIf cfg.enable {
    services.cloudflare-warp.enable = true;
  };
}
