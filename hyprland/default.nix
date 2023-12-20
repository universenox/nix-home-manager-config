{ lib, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprpicker # colorpicker
    hyprpaper # wallpapers
    waybar

    brightnessctl # for shortcut
    pavucontrol # for waybar on-click
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };
  home.file.".config/hypr/appearance.conf".source = ./appearance.conf;

  # to find display, call `xrandr`. '*' doesn't work...
  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ~/Pictures/Wallpapers/pink-flowers.jpg
    wallpaper = eDP-1, ~/Pictures/Wallpapers/pink-flowers.jpg
    ipc = off
  '';
  home.file.".config/waybar/".source = ./waybar;
}
