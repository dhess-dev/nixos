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
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./modules
          #./systems/heimRechner/configuration.nix
          #./systems/vm/configuration.nix
          ./systems/framework/configuration.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.dhess = import ./home-manager/home.nix;

            # Enable Bluetooth services
            hardware.bluetooth.enable = true;
            hardware.bluetooth.powerOnBoot = true;

            # Add user to Bluetooth group
            users.users.dhess.extraGroups = ["lp" "wheel" "bluetooth"];
            environment.systemPackages = with pkgs; [
              vscode
              neovim
              git
              alejandra # Formatter
              bluez # Bluetooth utilities
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
            ];
          }
        ];
      };
    };
  };
}
