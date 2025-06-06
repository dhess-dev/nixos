{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.dhess.desktop;
in {
  options.dhess.desktop = {
    enable = lib.mkEnableOption "Enable plasma desktop";
  };

  config = lib.mkIf cfg.enable {
    # some config
    # Enable the X11 windowing system.
    # You can disable this if you're only using the Wayland session.
    services.xserver.enable = true;

    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
    # Enable CUPS to print documents.
    services.printing.enable = true;
    dhess.zsh.enable = true;
  };
}
