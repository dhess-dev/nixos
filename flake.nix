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
    pkgs = import nixpkgs { inherit system; };
  in {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
       # modules = [ ./systems/heimrechner/configuration.nix ];
        modules = [ ./systems/vm/configuration.nix ];  
      };
    };

    homeConfigurations = {
      dhess = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };
  };
}
