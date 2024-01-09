{ lib, config, pkgs, nix-colors, ... }:
{
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  imports = [
    ./emacs.nix
    ./shell-pkgs.nix
    ./hyprland
    ./zsh
    nix-colors.homeManagerModules.default
  ];

  # https://tinted-theming.github.io/base16-gallery/
  colorScheme = nix-colors.colorSchemes.tokyo-night-storm;

  home = {
    stateVersion = "23.11"; # no touchy
    username = "kim";
    homeDirectory = "/home/kim";
    keyboard.layout = "us";

    file = { };
    packages = with pkgs; [
      # todo; put this into a separate generic "c/c++ shell" thing.
      # gcc and clang both provide c++ binary. we'll just use gcc's in our $PATH.
      (hiPrio gcc13)
      clang_17
      clang-tools_17
      gdb
      valgrind
      kcachegrind
      gnumake
      cmake
      graphviz
      nixpkgs-fmt
      zydis # disassembler

      nomachine-client # remote desktop for work


      firefox
      leetcode-cli

      anki

      pass
      discord
      qbittorrent
      obs-studio
      pandoc
      vlc
      neofetch
      texliveFull
      gimp

      # wayland screenshot... 
      swappy
      slurp
      grim

      # fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji

      # fira needed for emojis on `lsd`
      fira-code
      fira-code-symbols
      fira-code-nerdfont

      # mpd client, tried a bunch of others, they suck.
      # i don't like this much either but its manpage is good and it works.
      mpc-cli

      handlr # a better xdg-open?
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

  # japanese
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-mozc fcitx5-gtk ];
  };

  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
  };
}
