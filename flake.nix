{
description = "mald";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
     webcord.url = "github:fufexan/webcord-flake";
     home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };    
      nix-gaming.url = "github:fufexan/nix-gaming";
  }; 
  
  outputs = { nixpkgs, home-manager, ... }@ inputs: 
    let
  
     system = "x86_64-linux"; 
           pkgs = import nixpkgs {
            inherit system;
             config = { allowUnfree = true; };
           };

      lib = nixpkgs.lib;
     in
    {
      homeConfigurations."vboob" = home-manager.lib.homeManagerConfiguration {
        # pkgs = nixpkgs.legacyPackages.${system};
        inherit pkgs;
        modules = [
          ./users/vboob/home.nix
          
          {
            home = {
              username = "vboob";
              homeDirectory = "/home/vboob";
              stateVersion = "22.05";
            };
          }
        ];
      };

      nixosConfigurations = {
      nixos = lib.nixosSystem {
        specialArgs = { inherit inputs; };
        inherit system; 
              modules = [
         ./system/configuration.nix
       ];
      };
    };
  };
}
