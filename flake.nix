{
  description = "Home Manager configuration of kim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    user-shell.url = "path:user-shell";
    user-shell.inputs.home-manager.follows = "home-manager";

    #hyprland.url = "github:hyprwm/Hyprland";
    nix-colors.url = "github:misterio77/nix-colors";

    theme = {
      url = "./theme.nix";
      flake = false;
    };

    user-shell.inputs.nixpkgs.follows = "nixpkgs";
    user-shell.inputs.theme.follows = "theme";
  };
  outputs = { nixpkgs, home-manager, nix-colors, user-shell, theme, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      # https://tinted-theming.github.io/base16-gallery/
    in
    {
      homeConfigurations."home" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit nix-colors theme; };
        modules = [
          nix-colors.homeManagerModules.default
          user-shell.homeManagerModules.default
          ./nixpkgs-vlc-fix.nix
          ./common.nix
          ./home-home.nix
        ];
      };
      homeConfigurations."vps" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit nix-colors theme; };
        modules = [
          nix-colors.homeManagerModules.default
          user-shell.homeManagerModules.default
          ./common.nix
          ./home-vps.nix
        ];
      };
      homeConfigurations."work" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit nix-colors theme; };
        modules = [
          nix-colors.homeManagerModules.default
          user-shell.homeManagerModules.default
          ./common.nix
          ./home-work.nix
        ];
      };
    };
}
