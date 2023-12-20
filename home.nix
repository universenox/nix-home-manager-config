{ lib, config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  imports = [ ./emacs.nix ./shell-pkgs.nix ./hyprland ./zsh ];

  home = {
    stateVersion = "23.11"; # no touchy
    username = "kim";
    homeDirectory = "/home/kim";
    keyboard.layout = "us";

    file = { };
    packages = with pkgs; [
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

      firefox

      pass
      discord
      qbittorrent
      obs-studio
      pandoc
      vlc
      neofetch
      texliveFull
      gimp

      # fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji

      # fira needed for emojis on `lsd`
      fira-code
      fira-code-symbols
      fira-code-nerdfont
    ];
  };

  programs = {
    git = {
      enable = true;
      userName = "Kimberly Swanson";
      userEmail = "khswanson24@gmail.com";
      ignores = [ "*~" "*.swp" ];
    };
  };
}
