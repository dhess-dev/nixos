{
  pkgs,
  inputs,
  ...
}: let
  dotnet = pkgs.dotnetCorePackages.sdk_10_0;
in {
  home.sessionVariables = {
    DOTNET_ROOT = "${dotnet}/share/dotnet";
    MSBUILDTERMINALLOGGER = "auto";
  };
  home.packages = [
    # Compilers
    dotnet
    pkgs.glow
    pkgs.tokei
    pkgs.difftastic
  ];
}
