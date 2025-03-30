{ pkgs, ... }:
{
  home = {
    username = "kim";
    homeDirectory = "/home/kim";

    packages = with pkgs; [
      firefox
      syncthing
      pass

      # w
      zoom-us

      # unable to use most recent update.
      citrix_workspace_24_08_0

      anki
      yt-dlp
      obs-studio
      telegram-desktop
      discord
      chromium
      
      handlr # a better xdg-open?
      scrcpy # phone screen mirroring (scrcpy --video-source=display)
      leetcode-cli

      android-studio
      android-file-transfer # mainly for eink device since phone has syncthing

      keymapp
      qbittorrent
      vlc
      mpv # better!?

      pandoc
      libreoffice
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
}
