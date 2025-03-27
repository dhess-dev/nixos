{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dhess.dotnet;
in {
  options.dhess.dotnet = {
    enable = lib.mkEnableOption "Enable .NET";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.dotnetCorePackages.sdk_9_0;
      description = "The .NET SDK to install";
    };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [cfg.package];
    environment.sessionVariables = {
      DOTNET_ROOT = "${cfg.package}/share/dotnet";
      MSBUILDTERMINALLOGGER = "auto";
    };
  };
}
