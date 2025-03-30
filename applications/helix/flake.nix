{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helix-base16-themes = {
      url = "github:tinted-theming/base16-helix";
      flake = false;
    };
  };
  outputs = {helix, helix-base16-themes, ... }:
    let
      themesDir = "${helix-base16-themes}/themes/";
    in
    {
      homeManagerModules.default =
        { ... }: (import ./default.nix { inherit themesDir; helixpkg=helix.packages.x86_64-linux.helix; });
    };
}
