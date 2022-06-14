{
description = "mald";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
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
    in {
    homeManagerConfigurations = {
      vboob = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
           username = "vboob";
           homeDirectory = "/home/vboob";
           configuration = {
    imports = [
    ./users/vboob/home.nix
    ];  
   };
  };
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
