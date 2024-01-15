{ pkgs, inputs, ... }:
{
  # prompt
  programs.starship.enable=true;
  home.file.".config/starship.toml".source = ./starship.toml;
  
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    # todo: cdpath seems useful for work? (dir structure)
    
    shellAliases = {
      b = "source ~/.zshrc";
      nd = "nix develop --command zsh";
    };
    sessionVariables = {
      ZSH_AUTOSUGGEST_STRATEGY = [ "history" ];
    };
    initExtra = ''
      bindkey '^ ' autosuggest-accept
    '';
    plugins = [
      {
        name = "nix-zsh-completions";
        file = "nix-zsh-completions.plugin.zsh";
        src = inputs.zplug-nix-zsh-completions;
      }
      {
        name = "fzf-tab";
        file = "fzf-tab.plugin.zsh";
        src = inputs.zplug-fzf-tab;       
      }
      {
        name = "nix-shell";
        file = "nix-shell.plugin.zsh";
        src = inputs.zplug-nix-shell;
      }
      {
        name = "zsh-syntax-highlighting";
        file = "zsh-syntax-highlighting.plugin.zsh";
        src = inputs.zplug-zsh-syntax-highlighting;
      }
    ];
  };
}
