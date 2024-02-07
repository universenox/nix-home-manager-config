{ pkgs, inputs, ... }:
{
  # prompt
  programs.starship.enable = true;
  home.file.".config/starship.toml".source = inputs.starship-config;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      nd = "nix develop --command zsh";
    };
    sessionVariables = {
      ZSH_AUTOSUGGEST_STRATEGY = [ "history" ];
      SHELL = "zsh";
    };
    initExtra = ''
      bindkey '^ ' autosuggest-accept
      # put comment after cmd to help find it in history?
      setopt interactivecomments
    '';
    plugins =
      let
        mkPlugin = name: {
          name = "${name}";
          file = "${name}.plugin.zsh";
          src = inputs."zplug-${name}";
        };
      in
      [
        (mkPlugin "nix-zsh-completions")
        (mkPlugin "fzf-tab")
        (mkPlugin "nix-shell")
        (mkPlugin "zsh-syntax-highlighting")
      ];
  };
}
