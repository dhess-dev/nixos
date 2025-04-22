{
  pkgs,
  inputs,
  ...
}: let
  jetbrains-plugins = ["ideavim"];
in {
  home.packages = with pkgs; [
    # Editors
    vscode
    kdePackages.kate

    # https://nixos.wiki/wiki/Jetbrains_Tools
    (jetbrains.plugins.addPlugins jetbrains.rider jetbrains-plugins)
    (jetbrains.plugins.addPlugins jetbrains.rust-rover jetbrains-plugins)
    (jetbrains.plugins.addPlugins jetbrains.webstorm jetbrains-plugins)
    jetbrains-toolbox
  ];
}
