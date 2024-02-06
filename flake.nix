{
  description = "Home Manager configuration of kim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    my-zsh.inputs.nixpkgs.follows       = "nixpkgs";
    
    home-manager.url = "github:nix-community/home-manager";
    my-zsh.url = path:./zsh;
    my-zsh.inputs.home-manager.follows = "home-manager";

    #hyprland.url = "github:hyprwm/Hyprland";
    nix-colors.url = "github:misterio77/nix-colors";
    helix-base16-themes = { 
      url = "github:tinted-theming/base16-helix";
      flake = false;
    };
  };
  outputs = { nixpkgs, home-manager, nix-colors, my-zsh, helix-base16-themes, ... }:
  let 
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    homeConfigurations."kim" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit nix-colors helix-base16-themes; };
      modules = [ 
        nix-colors.homeManagerModules.default
        ./nixpkgs-vlc-fix.nix
        ./common.nix
        ./home.nix 
        my-zsh.homeManagerModules.default 
      ];
    };
    # work. 
    homeConfigurations."kswanson" = home-manager.lib.homeManagerConfiguration {
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
