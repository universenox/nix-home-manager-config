{ pkgs, inputs, ... }:
{
  # prompt
  programs.starship.enable = true;
  home.file.".config/starship.toml".source = ./starship.toml;

  home = {
    shellAliases = {
      which = "type -a";
      cat = "${pkgs.bat}/bin/bat --paging=never";
      catp = "${pkgs.bat}/bin/bat --no-paging --plain";
      cppshell = let file = ./devShells/cpp; in "nix develop ${file}";
      ls = "${pkgs.lsd}/bin/lsd";
    };

    sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
    };
  };
  programs = {
    helix.enable = true;
    bash.enable = true;
    zsh = {
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
  };
}
