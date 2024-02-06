{ lib, config, pkgs, ... }:
with config.colorScheme.palette;
{
  imports = [ ./waybar.nix ];

  home.packages = with pkgs; [
    hyprland # only necessary when not on system...
    hyprpicker # colorpicker
    hyprpaper # wallpapers
    waybar

    brightnessctl # for shortcut
    pavucontrol # for waybar on-click

    # extra font for the waybar
    powerline-fonts
  ];

  home.file.".config/hypr/hyprland.conf"  .source = ./hyprland.conf;

  home.file.".config/hypr/appearance.conf".text =
    builtins.readFile (./appearance.conf)
    +
    ''
  general { 
    col.active_border = rgba(${base00}ff) rgba(${base05}cc) 45deg 
    col.inactive_border = rgba(${base08}00)  
  }

  decoration { 
    col.shadow = rgba(${base0A}ee) 
  }

  '';

  # to find display, call `xrandr`. glob '*' doesn't work...
  home.file.".config/hypr/hyprpaper.conf".text =
    let wall = "~/Pictures/Wallpapers/coffee2.jpg"; in
    ''
      preload = ${wall}
      wallpaper = eDP-1, ${wall}
      ipc = off
    '';
}
