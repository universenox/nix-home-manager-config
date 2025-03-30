# common across all configurations
{ pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;
  xdg.enable = true;

  # note the modules in my flake are also "common"
  imports = [
    ./applications/git.nix
    ./applications/tmux.nix
    ./applications/rofi
    ./config/shell_aliases_fns.nix
    ./config/starship_prompt.nix
  ];

  # Lots of config does not belong in nix. It's very dynamic / doesn't utilize any nix stuff.
  # So, we just use nix to create the symlinks. Config is in git.
  # If it doesn't belong in common, move it to user.
  home.activation = {
    directlink = let
      refPath = "$HOME/.config/home-manager/directly-refd";
    in
    lib.hm.dag.entryAfter [ "writeBoundary" ] (''
      $DRY_RUN_CMD ln -sfvn ${refPath}/shell-extra $HOME/.shell-extra

      $DRY_RUN_CMD ln -sfvn ${refPath}/bin $HOME/bin

      for x in $(ls ${refPath}/config/); do
        $DRY_RUN_CMD ln -sfvn $(realpath $x) $HOME/.config/
      done
    '');
  };

  home = {
    stateVersion = "23.11"; # no touchy
    keyboard.layout = "us";
    sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
    };

    packages = with pkgs; [
      # generic CLI tools
      lnav # log navigator, amazing.
      ripgrep
      fd       # find alt
      tree
      sd # sed alt
      lsd # ls alt
      choose # cut alt
      hyperfine # time alt
      huniq
      zip
      ranger # cli file browser
      file # optional dep of ranger
      fastfetch
      tokei # count LoC
      tealdeer # tldr alt
      xclip

      ############################
      # dev tools
      ############################      
      stdmanpages # gcc c++ std
      linux-manual # linux kernel API
      man-pages # linux dev

      inetutils # telnet, etc
      moreutils # errno
      socat

      # vscode # apparently has a great MR-resolver / git utils; must check out.

      jinja2-cli
      jq
      miller # like jq but for any tabular
      yq # jq for yaml
      sqlfluff # sql formatter / linter

      shellcheck
      shfmt
  
      nix-tree
      nixfmt

      marksman
      dprint

      nil # nix lang serv
      vscode-langservers-extracted # html css json eslint
      ############################      

      timewarrior
      buku # bookmarks
      lazygit
      btop

      gdu # du alt
      glow # render markdown in cli
      openssl

      # can use to generate qr codes of keys. 
      (gnupg.override({ guiSupport = true; }))
      paperkey
      qrencode

      # fonts (`fc-list`)
      fira-code-symbols
      nerd-fonts.fira-code
      noto-fonts-color-emoji
      nerd-fonts.noto
      hack-font
    ];
    file.".dprint.json".source = ./config/dprint.json;
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
    # direnv breaks aliases in shellHooks...?
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    lesspipe.enable = false; # pita
    bash.enable = true;
    starship.enable = true;
  };
}
