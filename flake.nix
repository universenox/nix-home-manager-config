{
  description = "Home Manager configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    zsh.url = "path:applications/zsh";
    helix.url = "path:applications/helix";
    colors.url = "path:colors/";
    st.url = "path:applications/st";

    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { nixpkgs, home-manager, zsh, helix, colors, st,... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      # pkgs = import nixpkgs { inherit system; overlays = [ ]; };

      mkHome = home-id: {
        name = "${home-id}";
        value = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit home-id colors; };
          modules = 
          [
            zsh.homeManagerModules.default
            colors.homeManagerModules.default
            st.homeManagerModules.default
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
