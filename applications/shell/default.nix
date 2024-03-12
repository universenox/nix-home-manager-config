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
      ripgrep
      fd # find alt
      sd # sed alt
      lsd # ls alt
      choose # cut alt
      gdu # du alt
      jq # json
      socat
      openssl
      mkpasswd
      btop
      lnav # log navigator, looks promising.
      tree
      lazygit

      shellcheck
      shfmt

      tokei # count LoC
      tealdeer # tldr alt

      buku # bookmarks
      taskwarrior
      timewarrior

      ranger # cli file browser
      file # optional dep of ranger
      nixpkgs-fmt
      nix-tree

      fastfetch
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
