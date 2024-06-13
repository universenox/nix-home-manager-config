{
  description = "Generic Modern C++ dev env";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      llvmPackages = pkgs.llvmPackages_18;

      # comment this out to use default gcc one.
      dev-stdenv = llvmPackages.libcxxStdenv;

      compileInputs = with pkgs; [ 
          cmake
          boost183
          boostext-ut.defaultPackage.x86_64-linux
          fmt
          ( gbenchmark.override{ stdenv=dev-stdenv; })
          ( abseil-cpp.override{ stdenv=dev-stdenv; })
      ];

      devShellPackages = with pkgs; [
          ninja

          clang-tools_18 # This clangd works. clangd in other package bad.
          llvmPackages.lldb
          llvmPackages.clang-manpages
          llvmPackages.llvm-manpages
          llvmPackages.bintools

          cmake-format
          doxygen
          gdb
          valgrind
          kcachegrind
          python312
      ];
    in
    with pkgs;{
      # `nix develop` shell
      devShells.x86_64-linux.default = 
      ( mkShell.override { stdenv=dev-stdenv; }) 
      {
        name = "cppshell";
        packages = devShellPackages;
        buildInputs = compileInputs;

        CMAKE_EXPORT_COMPILE_COMMANDS=''1'';
        CMAKE_GENERATOR              =''Ninja'';
      };
    };
}
