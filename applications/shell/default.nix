{ pkgs, inputs, ... }:
{
  # this for "shell" also includes the very many cli utils I like c:
  imports = [ ./shell_aliases_fns.nix ];

  # prompt
  programs.starship.enable = true;
  home.file.".config/starship.toml".source = ./starship.toml;

  home = {
    sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
    };

    packages = with pkgs; [
      lnav # log navigator, amazing.
      ripgrep
      #fd       # find alt
      tree
      sd # sed alt
      lsd # ls alt
      choose # cut alt

      timewarrior
      taskwarrior
      buku # bookmarks
      lazygit
      btop

      ranger # cli file browser
      file # optional dep of ranger
      fastfetch

      nixpkgs-fmt
      nix-tree
      shellcheck
      shfmt

      tokei # count LoC
      tealdeer # tldr alt

      gdu # du alt
      jq # json
      openssl
      socat
      ascii # ascii table
    ];
  };
  programs = {
    atuin.enable = true; # cmd history
    fzf = {
      enable = true;
      tmux.enableShellIntegration = true;
    };
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
      tmuxinator.enable = true; # sessions
      escapeTime = 0;
      terminal = "xterm-256color";
      shell = "${pkgs.zsh}/bin/zsh";
      extraConfig = "";
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      sessionVariables = {
        ZSH_AUTOSUGGEST_STRATEGY = [ "history" "completion" ];
        SHELL = "zsh";
      };

      initExtra = ''
        bindkey '^ ' autosuggest-accept
        # put comment after cmd to help find it in history?
        setopt interactivecomments

        ###
        # suggestions from fzf-tab  
        ###
        # disable sort when completing `git checkout`
        zstyle ':completion:*:git-checkout:*' sort false
        # set descriptions format to enable group support
        # NOTE: don't use escape sequences here, fzf-tab will ignore them
        zstyle ':completion:*:descriptions' format '[%d]'
        # set list-colors to enable filename colorizing
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
        zstyle ':completion:*' menu no
        # preview directory's content with lsd when completing cd
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color=always $realpath'
        # switch group using `<` and `>`
        zstyle ':fzf-tab:*' switch-group '<' '>'      
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
