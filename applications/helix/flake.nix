{
  inputs = {
    helixpkg.url = "github:helix-editor/helix";
    helix-base16-themes = {
      url = "github:tinted-theming/base16-helix";
      flake = false;
    };
  };
  outputs = { nixpkgs, home-manager, helixpkg, helix-base16-themes, ... }:
    let
      nixpkgs.overlays = [ helixpkg.overlays ];
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      themesDir = "${helix-base16-themes}/themes/";
    in
    {
      homeManagerModules.default =
        (import ./default.nix { inherit home-manager pkgs themesDir; });
    };
}
