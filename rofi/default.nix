{ lib, config, pkgs, ... }:
{
  home.shellAliases = {
    run = "rofi -show drun";
    emoji = "rofi -show emoji"; # emojis do not show. but shows in kitty so idk.
    window = "rofi -show window";
  };

  home.packages = [ pkgs.wtype ];

  home.file.".config/rofi/ktheme.rasi".text =
    with config.colorScheme.colors;
    ''
      * {
        bg0: #${base02};
        fg0: #${base08};

        bg1: #${base03};
        fg1: #${base09};

        bg2: #${base04};
        fg2: #${base0A};
      }
    '' + builtins.readFile (./rofi-theme.rasi);

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = with pkgs; [ rofi-emoji ];
    extraConfig = {
      modi = "drun,window,emoji";
      disable-history = false;
      show-icons = true;
    };
    theme = "ktheme";
  };
}
