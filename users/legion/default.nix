{ pkgs, color, ... }@inputs:
{
  imports = [
    ../../common.nix
    ../../applications/hyprland
    ../../applications/rofi
    ../../applications/git
    ./taskw-export-timer.nix
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
      pass
      neofetch
      handlr # a better xdg-open?

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
      tauon # music
      obs-studio
      pandoc
      discord
      texliveFull # this is pretty big...
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
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [ fcitx5-mozc fcitx5-gtk ];
  };

  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
  };
}
