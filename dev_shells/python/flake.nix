{
  description = "Dummy python env";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs @ { nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      pythonver = pkgs.python313;

      # populate packages here...
      # actually, I prefer poetry!?
      # pythonEnv = pkgs.${pythonver}.withPackages (p: with p; [ ]);
    in
    with pkgs;{
      devShells.x86_64-linux.default = mkShell {
        name = "pythonshell";
        packages = with pkgs; [ pythonver poetry ];
      };
    };
}

