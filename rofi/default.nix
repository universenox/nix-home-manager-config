{ lib, config, pkgs, ... }:
{
  home.shellAliases = {
    run = "rofi -show drun";
    emoji = "rofi -show emoji"; # emojis do not show. but shows in kitty so idk.
    window = "rofi -show window";
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = with pkgs; [ rofi-emoji ];
    extraConfig = {
      modi = "drun,window,emoji";
    };
    theme = ./rofi-theme.rasi;
  };
}
