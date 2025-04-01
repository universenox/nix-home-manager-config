# common across all configurations
{ pkgs, lib, home-id, ... }:
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
  ];

  # Lots of config does not belong in nix. It's very dynamic / doesn't utilize any nix stuff.
  # So, we just use nix to create the symlinks. Config is in git.
  # If it doesn't belong in common, move it to module.
  home.activation = {
    directlink = let
      refPath = "$HOME/.config/home-manager/directly-refd";
    in
    lib.hm.dag.entryAfter [ "writeBoundary" ] (''
      #####
      # common
      #####
      $DRY_RUN_CMD ln -sfvn ${refPath}/shell-extra $HOME/.shell-extra

      $DRY_RUN_CMD ln -sfvn ${refPath}/bin $HOME/bin

      $DRY_RUN_CMD ln -sfvn -t $HOME/.config ${refPath}/config

      for x in $(ls ${refPath}/config/); do
        $DRY_RUN_CMD ln -sfvn $(realpath $x) $HOME/.config
      done

      #####
      # module-specific
      #####
       
      HMU=$HOME/.config/home-manager/users/${home-id}

      if [ -f $HMU/shell-extra/initextra.sh ]; then
        $DRY_RUN_CMD ln -sfvn $HMU/shell-extra $HOME/.shell-extra/module
      fi

      # this will end up having the common one symlink to the module one.
      # it's fine!
      # module-specific config
      if [ -d $HMU/config ]; then
        $DRY_RUN_CMD ln -sfv -t $HOME/.config $HMU/config/*
      fi

      # module-specific bin
      if [ -d $HMU/bin ]; then
        $DRY_RUN_CMD ln -sfv -t $HOME/.config $HMU/bin/*
      fi
    '');
  };

  home = {
    stateVersion = "23.11"; # no touchy
    keyboard.layout = "us";

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
      colorized-logs # ansi2txt remove color codes

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
    atuin = { # cmd history
      enable = true;
      settings = {
        auto_sync = false;
        filter_mode = "global";
        filter_mode_shell_up_keybinding = "session";
      };
    };
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
    bash = {
      enable = true;
      historyFileSize = 20000;
      historySize = 20000;
      shellOptions = [
        "histappend"
        "checkwinsize"
        "extglob"
        "checkjobs"
      ];
    };
    starship.enable = true;
  };
}
