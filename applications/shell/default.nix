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
      o = "xdg-open";
      tmux="TERM=screen-256color-bce tmux"; # destroys color otherwise
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
    fzf = {
      enable = true;
      tmux.enableShellIntegration=true;
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

      extraConfig = ''
      set -sg escape-time 0
      '';
      #set-option -sa terminal-overrides ",xterm-kitty:RGB"
      #set -g default-terminal "screen-256color"
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        nd = "nix develop --command zsh";
        la = "ls -a";
        cdr="cd $(git rev-parse --show-toplevel)";
      };
      sessionVariables = {
        ZSH_AUTOSUGGEST_STRATEGY = [ "history" ];
        SHELL = "zsh";
      };
      initExtra = ''
        bindkey '^ ' autosuggest-accept
        # put comment after cmd to help find it in history?
        setopt interactivecomments

        # functions
        function cl() {
          cd $1 && la
        }
        function mkcd() {
          test -d "$1" && echo "directory $1 already existed.  Entering it..."
          test -d "$1" || mkdir -p "$1"
          test -d "$1" && cd "$1"
        }
        function cu() {
          if [ $# -eq 0 ]; then
              ascend=1;
          else
              ascend=$1;
          fi
          local path=""
          for ((i=1;i<=$ascend;i++)); do
              path="../$path"
          done
          cd "$path"
        }
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
