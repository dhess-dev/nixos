{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dhess.dotnet;
  dotnet-combined = pkgs.dotnetCorePackages.combinePackages cfg.sdks;
in {
  options.dhess.dotnet = {
    enable = lib.mkEnableOption "Enable .NET";
    sdks = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs.dotnetCorePackages; [
        sdk_10_0
      ];
      description = "List of .NET SDKs to install";
    };
  };
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      dotnet-combined
    ];
    environment.sessionVariables = {
      DOTNET_ROOT = "${dotnet-combined}/share/dotnet";
      MSBUILDTERMINALLOGGER = "auto";
    };
  };
}
