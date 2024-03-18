{ pkgs, inputs, ... }:
{
  # this for "shell" also includes the very many cli utils I like c:

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

    packages = with pkgs; [
      lnav     # log navigator, amazing.
      ripgrep
      fd       # find alt
      tree
      sd       # sed alt
      lsd      # ls alt
      choose   # cut alt

      timewarrior
      taskwarrior
      buku     # bookmarks
      lazygit
      btop

      ranger   # cli file browser
      file     # optional dep of ranger
      fastfetch

      nixpkgs-fmt
      nix-tree
      shellcheck
      shfmt

      tokei    # count LoC
      tealdeer # tldr alt

      gdu      # du alt
      jq       # json
      openssl
      socat  
      ascii    # ascii table
    ];
  };
  programs = {
    atuin.enable = true; # cmd history
    fzf.enable = true;
    bat.enable = true;    
    nix-index.enable = true; # nix-locate <cmd> to see what provides it
    less.enable = true;
    zoxide.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    helix.enable = true;
    bash.enable = true;
    tmux = {
      enable = true;
      keyMode = "vi";
      mouse = true;
      tmuxinator.enable = true; # should try it out.
    };
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
