{
  description = "Home Manager configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    zsh.url = "path:applications/zsh";
    helix.url = "path:applications/helix";
    colors.url = "path:colors/";
    st.url = "path:applications/st";
  };
  outputs = { nixpkgs, home-manager, zsh, helix, colors, st,... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

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
            helix.homeManagerModules.default # basically my IDE
            ./common.nix
            ./users/${home-id}
          ];
        };
      };
    in
    {
      homeConfigurations =
        (builtins.listToAttrs (map mkHome [ "personal" "work" ]));
    };
}
