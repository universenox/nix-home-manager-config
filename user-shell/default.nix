# All things that I consider essential to my user shell, including 
# CLI utils. Basically the minimal set that I want to share
# across all my envs.
#
# TODO: some of the utils may use a bit of disk space. VPS disk space is expensive.
# maybe move some of them out as needed.
{ pkgs, inputs, helix-base16-themes, theme, ... }:
{
  # prompt
  programs.starship.enable = true;
  home.file.".config/starship.toml".source = ./starship.toml;
  home.file.".config/helix/themes/".source = "${helix-base16-themes}/themes/";

  home = {
    shellAliases = {
      which = "type -a";
      cat = "${pkgs.bat}/bin/bat --paging=never";
      catp = "${pkgs.bat}/bin/bat --no-paging --plain";
      cppshell = let file = ./devShells/cpp; in "nix develop ${file}";
      ls = "${pkgs.lsd}/bin/lsd";
    };

    packages = with pkgs; [
      ripgrep
      btop
      fd # find alt
      sd # sed alt
      lsd # ls alt

      shellcheck
      shfmt

      # fira needed for emojis on `lsd`
      fira-code
      fira-code-symbols
      fira-code-nerdfont
    ];

    sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
    };
  };
  programs = {
    helix = {
      enable = true;
      defaultEditor = true;
      settings.theme = let th = (import theme).theme; in "base16-${th}";

      settings.editor = {
        rulers = [ 80 120 ];
      };
      languages.language =
        [
          { name = "cpp"; auto-format = true; }
        ];
    };
    bash.enable = true;
    atuin.enable = true; # cmd history
    fzf.enable = true;
    bat.enable = true;
    nix-index.enable = true;
    less.enable = true;
    zoxide.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
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
