{
  config,
  lib,
  defaultConfig,
  ...
}: let
  cfg = config.dhess.virtualbox;
in {
  options.dhess.virtualbox = {
    enable = lib.mkEnableOption "VirtualBox";
    enableExtensionPack = lib.mkEnableOption "VirtualBox host extension pack";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.host.enableExtensionPack = cfg.enableExtensionPack;
    users.users."${defaultConfig.user.username}".extraGroups = ["vboxusers"];

    # see: https://github.com/NixOS/nixpkgs/issues/363887#issuecomment-2536693220
    boot.kernelParams = ["kvm.enable_virt_at_load=0"];
  };
}
