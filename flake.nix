{
  description = "Home Manager configuration of kim";

  inputs =
  {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    my-zsh.url = path:./zsh;
    my-zsh.inputs.nixpkgs.follows = "nixpkgs";
    my-zsh.inputs.home-manager.follows = "home-manager";
    
    nix-colors.url = "github:misterio77/nix-colors";
  };
  outputs = { nixpkgs, home-manager, nix-colors, my-zsh, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # for home
      homeConfigurations."kim" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit nix-colors; };
        modules = [ 
          nix-colors.homeManagerModules.default
          ./common.nix
          ./home.nix 
          my-zsh.homeManagerModules.default 
        ];
      };
      # work. 
      homeConfigurations."work" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit nix-colors; };
        modules = [ 
          nix-colors.homeManagerModules.default
          ./common.nix
          ./work-home.nix 
          my-zsh.homeManagerModules.default
        ];
      };
    };
}
