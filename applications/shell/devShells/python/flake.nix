{
  description = "Dummy python env";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs @ { nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      # populate packages here.
      pythonEnv = pkgs.python311.withPackages (p: with p; [ ]);
    in
    with pkgs;{
      devShells.x86_64-linux.default = mkShell {
        packages = [ pythonEnv ];
      };
    };
}

