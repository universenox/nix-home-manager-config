# common across all configurations
{ pkgs,lib, nix-colors, ... }:
{
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  # note the modules in my flake are also "common"
  imports = [
    ./applications/kitty
    ./applications/git
    ./applications/tmux.nix
    ./config/shell_aliases_fns.nix
    ./config/starship_prompt.nix
  ];
  #### colors ####
  colorScheme = nix-colors.colorSchemes.gruvbox-material-dark-soft;
  programs.helix.settings.theme = "base16-gruvbox-material-dark-soft";
  programs.kitty.theme = "Gruvbox Material Dark Soft";
  ###############

  home = {
    stateVersion = "23.11"; # no touchy
    keyboard.layout = "us";
    sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
    };

    packages = with pkgs; [
      lnav # log navigator, amazing.
      ripgrep
      fd       # find alt
      tree
      sd # sed alt
      lsd # ls alt
      choose # cut alt
      hyperfine # time alt
      huniq 
      inetutils # telnet, etc

      python311Packages.pygments # some stuff uses it in zsh..
      grc

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
      glow # render markdown in cli
      miller # like jq but for any tabular
      zip
      openssl
      socat
      # ascii # ascii table; some OS come with one already.

      hack-font
      # fira needed for emojis on `lsd`
      fira-code
      fira-code-symbols
      fira-code-nerdfont

      vscode # apparently has a great MR-resolver / git utils; must check out.
      xclip
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
    lesspipe.enable = false; # pita
    bash.enable = true;
  };
}
