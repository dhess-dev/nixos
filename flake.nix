{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    # Central user configuration
    defaultConfig = {
      user = {
        username = "dhess";
        fullName = "Daniel Hess";
        email = "danielhess.dev@gmail.com";
        initialPassword = "password";
        authorizedKeys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOYFMRnokzxz0IKHKJA+9JRxj2IqxWXgF7bCDrXhrT55 danielhess.dev@gmail.com"
        ];
        extraGroups = ["wheel" "lp" "bluetooth" "networkmanager" "dialout"];
      };
    };
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    #  Dev shell for direnv / nix develop
    devShells.x86_64-linux.default = pkgs.mkShell {
      name = "nixos-dev-shell";
      buildInputs = with pkgs; [
        git
        neovim
        nodejs_22
        alejandra
      ];
      shellHook = ''
        echo "🛠️ DevShell activated"
      '';
    };

    # 💻 NixOS system configuration
    nixosConfigurations = {
      framework = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit defaultConfig;
        };
        modules = [
          ./modules
          ./systems/framework/configuration.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${defaultConfig.user.username} = {
              config,
              pkgs,
              lib,
              ...
            }: (import ./home-manager/home.nix {
              inherit pkgs lib defaultConfig;
              inherit config;
            });
            users.users.${defaultConfig.user.username} = {
              isNormalUser = true;
              initialPassword = defaultConfig.user.initialPassword;
              extraGroups = defaultConfig.user.extraGroups;
              openssh.authorizedKeys.keys = defaultConfig.user.authorizedKeys;
              description = defaultConfig.user.fullName;
            };
            environment.systemPackages = with pkgs; [
              vscode
              neovim
              git
              alejandra
              bluez
              jetbrains-toolbox
              jetbrains.rider
              google-chrome
              nodejs_22
              losslesscut-bin
              brave
              keepassxc
              nextcloud-client
              discord
              pkgs.wasm-tools
              dbeaver-bin
              pkgs.rpi-imager
              pkgs.onlyoffice-desktopeditors
              protonvpn-cli
              arduino
              unzip
              jdk21
              openssl
              wget
              vscode-fhs
              obsidian
              xournalpp
              steam
            ];

            hardware.bluetooth.enable = true;
            hardware.bluetooth.powerOnBoot = true;
          }
        ];
      };
      squirtmaster = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit defaultConfig;
        };
        modules = [
          ./modules
          ./systems/squirtmaster/configuration.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${defaultConfig.user.username} = {
              config,
              pkgs,
              lib,
              ...
            }: (import ./home-manager/home.nix {
              inherit pkgs lib defaultConfig;
              inherit config;
            });
            users.users.${defaultConfig.user.username} = {
              isNormalUser = true;
              initialPassword = defaultConfig.user.initialPassword;
              extraGroups = defaultConfig.user.extraGroups;
              openssh.authorizedKeys.keys = defaultConfig.user.authorizedKeys;
              description = defaultConfig.user.fullName;
            };
            environment.systemPackages = with pkgs; [
              vscode
              neovim
              git
              alejandra
              bluez
              jetbrains-toolbox
              jetbrains.rider
              google-chrome
              nodejs_22
              losslesscut-bin
              brave
              keepassxc
              nextcloud-client
              discord
              pkgs.wasm-tools
              virtualbox
              dbeaver-bin
              pkgs.rpi-imager
              pkgs.onlyoffice-desktopeditors
              ppsspp-sdl-wayland
              protonvpn-gui
            ];

            hardware.bluetooth.enable = true;
            hardware.bluetooth.powerOnBoot = true;
          }
        ];
      };
    };
  };
}
