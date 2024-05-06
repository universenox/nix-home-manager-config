{
  description = "Home Manager configuration";
  inputs = {
    # careful, different version between home vs OS; suspect interops may break.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";

    # Use `follows` because I don't want several versions of * repo at once. 
    # More likely to break on update, though (since they'd have likely tested 
    # with the version their flake has pinned, rather than the one I'm giving it).
    
    zsh.url = "path:applications/zsh";
    #zsh.inputs.home-manager.follows = "home-manager";
    # shell.inputs.nixpkgs.follows = "nixpkgs";

    helix.url = "path:applications/helix";
    helix.inputs.nixpkgs.follows = "nixpkgs";
    helix.inputs.home-manager.follows = "home-manager";
    #helix.inputs.rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
  };
  outputs = { nixpkgs, home-manager, zsh, helix, nix-colors, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      mkHome = home-id: {
        name = "${home-id}";
        value = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit nix-colors home-id; };
          modules = 
          [
            nix-colors.homeManagerModules.default
            zsh.homeManagerModules.default
            helix.homeManagerModules.default
            ./common.nix
            ./users/${home-id}
          ];
        };
      };
    in
    {
      homeConfigurations =
        (builtins.listToAttrs (map mkHome [ "legion" "work" "vps" ]));
    };
}
