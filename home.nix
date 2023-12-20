{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;

  imports = [ ./emacs.nix ];

  home = {
    stateVersion = "23.11"; # no touchy
    username = "kim";
    homeDirectory = "/home/kim";

    shellAliases = {
      e = "vim";
    };

    file = {
      # dotfiles....
    };

    sessionVariables = {
      # env vars
      EDITOR = "vim";
    };

    packages = with pkgs; [
      firefox
      # gcc and clang both provide c++ binary. we'll just use gcc's in our $PATH.
      (hiPrio gcc13)
      clang_17
      gdb
      valgrind
      kcachegrind
      vscodium-fhs
      gnumake
      cmake
      graphviz
      nixpkgs-fmt

      pass
      discord
      qbittorrent
      obs-studio
      pandoc
      vlc
      neofetch
      texliveFull

      ripgrep
      fd
      sd
      thefuck
      gh
      lsd

      # fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      fira-code
      fira-code-symbols
    ];
  };
  programs = {
    bash.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    bat.enable = true;
    autojump.enable = true;
    zoxide.enable = true;
    nix-index.enable = true;
    lazygit.enable = true;
    git = {
      enable = true;
      userName = "Kimberly Swanson";
      userEmail = "khswanson24@gmail.com";
      ignores = [ "*~" "*.swp" ];
    };
  };
}
