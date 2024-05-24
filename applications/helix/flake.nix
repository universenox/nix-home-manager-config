{
  inputs = {
    helixpkg.url = "github:helix-editor/helix";
    helix-base16-themes = {
      url = "github:tinted-theming/base16-helix";
      flake = false;
    };
  };
  outputs = {helixpkg, helix-base16-themes, ... }:
    let
      themesDir = "${helix-base16-themes}/themes/";
    in
    {
      homeManagerModules.default =
        { ... }: (import ./default.nix { inherit themesDir helixpkg; });
    };
}
