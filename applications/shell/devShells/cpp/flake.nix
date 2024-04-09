{
  description = "Generic Modern C++ dev env";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs @ { nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    with pkgs;{
      devShells.x86_64-linux.default = mkShell {
        name = "cppshell";
        packages = [ 
          cmake
          bear

          boost183
          gbenchmark

          clang-tools_17
          llvmPackages_17.clang
          llvmPackages_17.clang-manpages

          llvmPackages_17.libcxxClang
          llvmPackages_17.lld
          llvmPackages_17.lldb
          
          cmake
          ninja
          doxygen
          cmake-format
          cmakeCurses 

          gdb
          valgrind 
          kcachegrind

          cppcheck
          
          ccache
          python312 
        ];
        shellHook = ''
          export CMAKE_EXPORT_COMPILE_COMMANDS=1;
          export CMAKE_GENERATOR=Ninja;
          # optim vs debug?
          #export CXXFLAGS='-O3';
          export CXX='clang++';
          export CC='clang';
          # alias set_debug_flags="export CXXFLAGS='-Wall -ggdb3 -O2 -fexperimental-library'" ;
          # alias set_prod_flags="export CXXFLAGS='-Wall -O3 -fexperimental-library'" ;
        '';
      };
    };
}
