{ pkgs, ... }@inputs:
{
  imports = [
    ./taskw-export-timer.nix
  ];

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "vps" = {
        host = "vps";
        hostname = "vps.vps.vpn.net";
        user = "kim";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

  home = {
    username = "kim";
    homeDirectory = "/home/kim";

    packages = with pkgs; [
      pass
      neofetch
      handlr # a better xdg-open?

      octaveFull
      ghostscript # dep of octave

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
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-mozc ];
  };
  # Would normally set this to fcitx, but kitty only supports ibus, and fcitx
  # provides an ibus interface. Can't use ibus for e.g. QT_IM_MODULE though,
  # because that at least breaks mumble
  home.sessionVariables.GLFW_IM_MODULE = "ibus";

  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
  };
}
