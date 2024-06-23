{ pkgs, ... }@inputs:
{
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

      nil # nix lang serv
      vscode-langservers-extracted # html css json eslint

      firefox
      leetcode-cli

      # zoom-us
      # slack
      # element-desktop

      android-studio
      android-file-transfer # mainly for eink device since phone has syncthing

      anki

      jiten # jp dictionary CLI
      noto-fonts-cjk # japanese

      qbittorrent
      vlc
      mpv # better!?
      yt-dlp
      obs-studio
      pandoc
      discord
      libreoffice
      # texliveFull
      gimp
      inkscape
    ];
  };

  programs = {
    git = {
      userName = "Kimberly Swanson";
      userEmail = "khswanson24@gmail.com";
    };
  };

  # japanese
  # i18n.inputMethod = {
  #   enabled = "fcitx5";
  #   fcitx5.addons = with pkgs; [ fcitx5-mozc ];
  # };
}
