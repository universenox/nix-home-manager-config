{
  description = "My Zsh Home-Manager Config";
  # zplug-* are my zsh plugins.
  inputs = {
    # hist db
    zplug-spaceship-prompt = {
      url = "github:spaceship-prompt/spaceship-prompt";
      flake = false;
    };
    zplug-nix-zsh-completions = {
      url = "github:spwhitt/nix-zsh-completions";
      flake = false;
    };
    # provides special arg suggestions for commands like git, ...
    zplug-fzf-tab = {
      url = "github:Aloxaf/fzf-tab";
      flake = false;
    };
    zplug-nix-shell = {
      url = "github:chisui/zsh-nix-shell";
      flake = false;
    };
    zplug-zsh-syntax-highlighting = {
      url = "github:zsh-users/zsh-syntax-highlighting";
      flake = false;
    };
    starship-config = {
      url = "path:./starship.toml";
      flake = false;
    };
    helix-base16-themes = {
      url = "github:tinted-theming/base16-helix";
      flake = false;
    };
  };
  outputs = inputs@{ nixpkgs, home-manager, helix-base16-themes, theme, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib = pkgs.lib;
    in
    {
      homeManagerModules.default =
        (import ./default.nix { inherit pkgs inputs helix-base16-themes theme; });
    };
}
