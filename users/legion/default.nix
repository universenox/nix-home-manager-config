{ pkgs, color, ... }@inputs:
{
  imports = [
    ../../common.nix
    ../../applications/rofi
    ../../applications/git
    ./taskw-export-timer.nix
  ];

  services.syncthing = {
    enable = true;
    tray.enable = true;
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "kimserv" = {
        host = "kimserv 185.193.158.96";
        hostname = "185.193.158.96";
        user = "kim";
      };
    };
  };

  home = {
    username = "kim";
    homeDirectory = "/home/kim";

    packages = with pkgs; [
      poetry
      pass
      neofetch
      handlr # a better xdg-open?

      octaveFull

      # wayland screenshot... 
      swappy
      slurp
      grim
      wl-clipboard # for helix yank to system clipboard

      nil # nix lang serv
      vscode-langservers-extracted # html css json eslint
      nginx # testing
      hugo

      firefox
      leetcode-cli

      zoom-us
      slack
      element-desktop

      android-studio
      android-file-transfer

      anki
      qbittorrent
      vlc
      mpv # better!?
      yt-dlp
      tauon # music
      obs-studio
      pandoc
      discord
      libreoffice
      texliveFull
      gimp
      inkscape

      nomachine-client # remote desktop for work
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
  # TODO.
  # i18n.inputMethod = {
  #   enabled = "fcitx5";
  #   fcitx5.addons = with pkgs; [ fcitx5-mozc fcitx5-gtk ];
  # };

  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
  };
}
