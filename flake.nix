{ 
   description = "My first flake";

   inputs = {
     nixpkgs.url = "nixpkgs/nixos-unstable";
     home-manager.url = "github:nix-community/home-manager";
     home-manager.inputs.nixpkgs.follows = "nixpkgs";
     };

   outputs = { self, nixpkgs, ...}:
    let
     lib = nixpkgs.lib;
     system = "x86_64-linux";
     pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
       nixos = lib.nixosSystem {
       inherit system;
       modules = [ ./configuration.nix ]; 
       };
     };
       homeConfiguration = {
        dhess = home-manager.lib.homeMangerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
        };
       };
   };
}
