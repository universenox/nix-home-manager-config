{
  description = "Generic Modern C++ dev env";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs @ { nixpkgs, ... }:
    let 
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in with pkgs;{
      devShells.x86_64-linux.default = mkShell { 
        packages = [clang_17 clang-tools_17 gdb valgrind kcachegrind gnumake cmake ninja doxygen cmake-format cmakeCurses python312 ccache];
      };
    };
}
