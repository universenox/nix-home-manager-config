{ ... }@inputs:
{
  programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      sessionVariables = {
        ZSH_AUTOSUGGEST_STRATEGY = [ "history" "completion" ];
      };
      envExtra = ''
        setopt no_global_rcs
      '';
      history = {
        append = true;
        ignoreAllDups = true;
        save = 20000;
        size = 20000;
      };
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
          (mkPlugin "nix-shell")
          (mkPlugin "fast-syntax-highlighting")
          (mkPlugin "you-should-use")
          (mkPlugin "fzf-source")
          (mkPlugin "fzf-tab")
        ];
    };
}
