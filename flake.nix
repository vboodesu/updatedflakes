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
 nixConfig = {
    substituters = [ "https://cache.nixos.org" "https://nix-gaming.cachix.org" ];
    trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
  };
  
  outputs = { nixpkgs, home-manager, ... }: 
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
       inherit system;

       modules = [
         ./system/configuration.nix
       ];
      };
    };
  
  };
}
