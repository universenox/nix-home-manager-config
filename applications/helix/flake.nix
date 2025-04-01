{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # helix = {
    #   url = "github:helix-editor/helix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    helix-base16-themes = {
      url = "github:tinted-theming/base16-helix";
      flake = false;
    };
  };
  outputs = {nixpkgs, helix-base16-themes, ... }:
    let
      themesDir = "${helix-base16-themes}/themes/";
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeManagerModules.default =
        { ... }: (import ./default.nix { inherit themesDir; helixpkg=pkgs.helix; });
    };
}
