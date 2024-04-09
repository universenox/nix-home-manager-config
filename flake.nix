{
  description = "Home Manager configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";

    # pretty bad.... but i don't want several versions of pkgs repo at once.
    
    shell.url = "path:applications/shell";
    shell.inputs.nixpkgs.follows = "nixpkgs";
    shell.inputs.home-manager.follows = "home-manager";

    helix.url = "path:applications/helix";
    helix.inputs.nixpkgs.follows = "nixpkgs";
    helix.inputs.home-manager.follows = "home-manager";
    #helix.inputs.rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-colors.url = "github:misterio77/nix-colors";
  };
  outputs = { nixpkgs, home-manager, shell, helix, nix-colors, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      mkHome = home-id: {
        name = "${home-id}";
        value = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit nix-colors; inherit home-id; };
          modules = [
            nix-colors.homeManagerModules.default
            shell.homeManagerModules.default
            helix.homeManagerModules.default
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
