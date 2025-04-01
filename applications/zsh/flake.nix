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
    zplug-fzf-source = {
      url = "github:Freed-Wu/fzf-tab-source";
      flake = false;
    };
    zplug-nix-shell = {
      url = "github:chisui/zsh-nix-shell";
      flake = false;
    };
    zplug-fast-syntax-highlighting = {
      url = "github:zdharma-continuum/fast-syntax-highlighting";
      flake = false;
    };
    zplug-you-should-use = {
      url = "github:MichaelAquilina/zsh-you-should-use";
      flake = false;
    };
  };
  outputs = inputs@{ ... }:
    # let
    #   system = "x86_64-linux";
    #   pkgs = nixpkgs.legacyPackages.${system};
    # in
    {
      # doesn't even use HM...
      homeManagerModules.default =
        (import ./default.nix inputs); 
    };
}
