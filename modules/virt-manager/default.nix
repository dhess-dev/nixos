{
  config,
  lib,
  pkgs,
  defaultConfig,
  ...
}: let
  cfg = config.dhess.virt-manager;
in {
  options.dhess.virt-manager = {
    enable = lib.mkEnableOption "Enable virt-manager + libvirt (QEMU/KVM)";
  };

  config = lib.mkIf cfg.enable {
    programs.virt-manager.enable = true;

    # User in die Gruppen
    users.groups = {
      libvirtd.members = [defaultConfig.user.username];
      kvm.members = [defaultConfig.user.username];
    };

    virtualisation.libvirtd = {
      enable = true;
      qemu.swtpm.enable = true; # optional
      # qemu.ovmf.enable = true; # ❌ removed in NixOS 26.05
    };

    virtualisation.spiceUSBRedirection.enable = true;

    networking.firewall.trustedInterfaces = ["virbr0"];

    # optional, aber hilfreich für manuelles QEMU / Debugging
    environment.systemPackages = with pkgs; [OVMF];
  };
}
