# common across all configurations
{ pkgs,... }:
{
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  # note the modules in my flake are also "common"
  imports = [
    ./applications/git.nix
    ./applications/tmux.nix
    ./config/shell_aliases_fns.nix
    ./config/starship_prompt.nix
  ];

  home = {
    stateVersion = "23.11"; # no touchy
    keyboard.layout = "us";
    sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
    };

    packages = with pkgs; [
      stdmanpages # gcc c++ std
      linux-manual # linux kernel API
      man-pages # linux dev
    
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

      timewarrior
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
      marksman
      dprint # md

      tokei # count LoC
      tealdeer # tldr alt

      gdu # du alt
      jq # json
      glow # render markdown in cli
      miller # like jq but for any tabular
      zip
      openssl
      socat


      # `fc-list`
      hack-font
      # fira needed for emojis on `lsd`
      fira-code
      fira-code-symbols
      fira-code-nerdfont

      vscode # apparently has a great MR-resolver / git utils; must check out.
      xclip
    ];
  };
  home.file.".dprint.json".source = ./config/dprint.json;
 
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
    # direnv breaks aliases in shellHooks...?
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    lesspipe.enable = false; # pita
    bash.enable = true;
  };
}
