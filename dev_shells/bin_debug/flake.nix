{
  description = "Env for debugging binaries";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs = { nixpkgs, ... }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
    with pkgs; {
      # `nix develop` shell
      devShells.x86_64-linux.default = mkShell
      {
        name = "bindebug-shell";
        packages = [
          gdb
          binutils # strings
          ltrace
        ];

        shellHook = ''
          # debug dynamic linker
          function debug_linker(){
            EXEC=$("$@")
            LD_BIND_NOW=1 \
            LD_TRACE_LOADED_OBJECTS=1 \
            LD_WARN=1 \
            $EXEC
          }
          export debug_linker
        '';
      };
    };
}
