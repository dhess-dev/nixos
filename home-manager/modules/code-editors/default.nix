{
  pkgs,
  inputs,
  ...
}: let
  # plugins are currently broken, see https://github.com/nixos/nixpkgs/issues/400317
  jetbrains-plugins = [];
in {
  home.packages = with pkgs; [
    # Editors
    vscode
    kdePackages.kate

    # https://nixos.wiki/wiki/Jetbrains_Tools
    (jetbrains.plugins.addPlugins jetbrains.rider jetbrains-plugins)
    (jetbrains.plugins.addPlugins jetbrains.rust-rover jetbrains-plugins)
    (jetbrains.plugins.addPlugins jetbrains.webstorm jetbrains-plugins)
    (pkgs.jetbrains.plugins.addPlugins pkgs.jetbrains.idea-ultimate jetbrains-plugins)
    jetbrains-toolbox
  ];
}
