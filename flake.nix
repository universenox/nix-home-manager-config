{
  description = "Home Manager configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zsh.url = "path:applications/zsh";

    helix = {
      url = "path:applications/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    colors.url = "path:colors/";
    st.url = "path:applications/st";

  };
  outputs = { nixpkgs, home-manager, zsh, helix, colors, st,... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      commonModules = [
        zsh.homeManagerModules.default
        colors.homeManagerModules.default
        helix.homeManagerModules.default
        ./common.nix
      ];

      mkHome = { home-id, additionalModules ? [] }: {
        name = "${home-id}";
        value = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit home-id colors; };
          modules = commonModules ++ additionalModules ++ [ ./users/${home-id} ];
        };
      };
    in
    {
      homeConfigurations =
        (builtins.listToAttrs (map mkHome [
          { home-id="personal"; additionalModules = [ st.homeManagerModules.default ]; }
          { home-id="work";  } # this is a stub because I'm not uploading my full work configuration to github. 
        ]));
    };
}
