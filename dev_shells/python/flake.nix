{
  description = "Generic Python dev env";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    with pkgs; {
      devShells.x86_64-linux.default = mkShell {
        name = "pyshell";
        # python packages are difficult. Prefer if nix has it, else use a python package manager (ie poetry)
        packages = with pkgs; [ 
          (python3.withPackages(p: with p; [
            jupyter
            pandas
            numpy
            matplotlib
          ]))
          poetry
        ];
      };
    };
}
