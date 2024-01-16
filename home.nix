{ lib, config, pkgs, nix-colors, ... }:
{
  imports = [
    ./kitty
    ./rofi
    ./hyprland
  ];

  home = {
    username = "kim";
    homeDirectory = "/home/kim";

    shellAliases = {
      # screenshot
      ss = "grim -g \"$(slurp -d)\" - | swappy -f -";
    };
    sessionVariables = {
    };

    # for nix-direnv
    # file.".env".text = ''
    #   use nix
    #   use flake
    # '';

    packages = with pkgs; [
      nomachine-client # remote desktop for work
      firefox
      leetcode-cli

      slack

      anki

      pass
      discord
      qbittorrent
      obs-studio
      pandoc
      vlc
      neofetch
      texliveFull # this is pretty big...
      gimp

      # wayland screenshot... 
      swappy
      slurp
      grim

      # music
      tauon

      noto-fonts-cjk # japanese

      gh # cli github

      wl-clipboard # for helix yank to system clipboard
      wayshot # todo: would like alternative.

      handlr # a better xdg-open?
    ];
  };
  programs = {
    git = {
      userName = "Kimberly Swanson";
      userEmail = "khswanson24@gmail.com";
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
