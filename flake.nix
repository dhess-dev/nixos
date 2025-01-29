{
  description = "My first flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;  # <---- Allow unfree packages here
    };
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        modules = [
          ./systems/vm/configuration.nix
          #./systems/heimRechner/configuration.nix 
	  {
            nixpkgs.config.allowUnfree = true;  # <---- Allow unfree packages here

            environment.systemPackages = with pkgs; [
              vscode 
              neovim
              git
            ];
          }
        ];  
      };
    };

    homeConfigurations = {
      dhess = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          {
            nixpkgs.config.allowUnfree = true;  # <---- Allow unfree packages for Home Manager
          }
        ];
      };
    };
  };
}

