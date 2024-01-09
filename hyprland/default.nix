{ lib, config, pkgs, ... }:
with config.colorScheme.colors;
{
  home.packages = with pkgs; [
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
    let wall = "~/Pictures/Wallpapers/fblue-trainstation.png"; in
    ''
      preload = ${wall}
      wallpaper = eDP-1, ${wall}
      ipc = off
    '';

  home.file.".config/waybar/style.css".text = ''
    * {
    	font-size: 16px;
    	font-family: "Noto";
    }

    window#waybar {
    	background: transparent;
    	color: #${base0A};
    }

    #workspaces,
    #clock,
    #pulseaudio,
    #pulseaudio,
    #memory,
    #cpu,
    #battery,
    #network,
    #disk,
    #term,
    #tray {
    	border-radius: 25px;
    	background: #${base01};
    	padding: 0 10px;
    }

    #workspaces button {
        padding: 0 5px;
        background: transparent;
        color: #${base0A};
        border-top: 2px solid transparent;
    }

    #workspaces button.focused {
        color: #${base0B};
        border-top: 2px solid #${base0C};
    }
  '';
  home.file.".config/waybar/config.json".source = ./waybar/config.json;


}
