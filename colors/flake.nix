{
  description = "colors configuration";
  inputs = {
    nix-colors.url = "github:misterio77/nix-colors";
  };
  outputs = { nix-colors, ... }:
  {
    homeManagerModules.default = { lib, ... }: (import ./default.nix { inherit lib nix-colors; } );
  };
}
