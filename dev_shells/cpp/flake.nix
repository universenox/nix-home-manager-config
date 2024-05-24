{
  description = "Generic Modern C++ dev env";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs @ { nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      llvmPackages = pkgs.llvmPackages_18;
    in
    with pkgs;{
      devShells.x86_64-linux.default = 
      ( mkShell.override { stdenv=llvmPackages.stdenv; }) 
      {
        name = "cppshell";
        packages = with llvmPackages; [ 
          stdmanpages
          linux-manual
          man-pages

          cmake
          bear # generates compile_commands.json from simple one-line compiler invocation
          ninja

          boost183
          gbenchmark

          clang-tools_18 # This clangd works. clangd in other package bad.
          llvmPackages.lld
          llvmPackages.lldb

          llvmPackages.clang-manpages
          llvmPackages.llvm-manpages
          llvmPackages.bintools
          llvmPackages.openmp
          
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
        buildInputs = [
          llvmPackages.libcxxClang
        ];

        CMAKE_EXPORT_COMPILE_COMMANDS=''1'';
        CMAKE_GENERATOR              =''Ninja'';
      };
    };
}
