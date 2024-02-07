{ lib, config, pkgs, nix-colors, ... }:
{
  imports = [
    ./hyprland
    ./taskw-export-timer.nix
    ./rofi
  ];

  services.syncthing = {
    enable = true;
    tray.enable = true;
  };

  home = {
    username = "kim";
    homeDirectory = "/home/kim";

    shellAliases = {
      hms = "home-manager switch --flake ~/.config/home-manager/#home";
      # screenshot
      ss = "grim -g \"$(slurp -d)\" - | swappy -f -";
    };

    sessionVariables = { };

    packages = with pkgs; [
      firefox
      leetcode-cli

      android-studio
      android-file-transfer

      zoom-us
      slack

      nil # nix lang serv

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
      wl-clipboard # for helix yank to system clipboard

      tauon # music

      handlr # a better xdg-open?

      nomachine-client # remote desktop for work
      realvnc-vnc-viewer # vps. but tbh prefer ssh.

      noto-fonts-cjk # japanese
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
