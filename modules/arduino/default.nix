{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.arduinoIDE;
in {
  options.modules.arduinoIDE = {
    enable = mkEnableOption "Arduino IDE 2.x AppImage support";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      arduino-core
      libusb1
      zlib
      xorg.libX11
      xorg.libXext
      xorg.libXrender
      xorg.libxcb
      xorg.libXrandr
      alsa-lib
      fontconfig
      freetype
      glib
      gtk3
      nss
      nspr
      curl
      dbus
      adwaita-icon-theme
      python3

      # Provide a binary that runs the AppImage in an FHS environment
      (pkgs.buildFHSEnv {
        name = "arduino2";
        runScript = "squashfs-root/AppRun";
        targetPkgs = pkgs:
          with pkgs; [
            python3
            fuse
            gtk3
            zlib
            curl
            nss
            nspr
            alsa-lib
            xorg.libX11
            xorg.libXext
            xorg.libxcb
            xorg.libXrandr
            glib
            fontconfig
          ];
      })
    ];

    services.udev.extraRules = ''
      SUBSYSTEM=="tty", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", GROUP="dialout", MODE="0666"
      SUBSYSTEM=="tty", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60", GROUP="dialout", MODE="0666"
    '';
  };
}
