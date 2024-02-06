{
  description = "Generic Go dev env";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs @ { nixpkgs, ... }:
    let 
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in with pkgs;{
      devShells.x86_64-linux.default = mkShell { 
        packages = [ go gopls gopkgs ];
      };
    };
}
