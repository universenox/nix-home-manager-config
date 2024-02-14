{
  description = "Home Manager configuration of kim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";


    # weirdness, https://github.com/NixOS/nix/issues/3978
    # but idc,
    shell.url = "path:applications/shell";
    helix.url = "path:applications/helix";

    nix-colors.url = "github:misterio77/nix-colors";
  };
  outputs = { nixpkgs, home-manager, shell, helix, nix-colors, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      mkHome = name: {
        name = "${name}";
        value = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit nix-colors; };
          modules = [
            nix-colors.homeManagerModules.default
            shell.homeManagerModules.default
            helix.homeManagerModules.default
            ./users/${name}
          ];
        };
      };
    in
    {
      homeConfigurations =
        (builtins.listToAttrs (map mkHome [ "legion" "work" "vps" ]));
    };
}
