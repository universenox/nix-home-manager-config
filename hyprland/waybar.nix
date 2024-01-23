{config, pkgs, ...}: {
  # Copied from johnk1917
  # then slightly modified.
  programs.waybar = with config.colorScheme.colors; {
    enable = true;
    systemd.enable = true;
    style = '' 
        * {
          border: none;
          font-family: JetBrainsMono Nerd Font, sans-serif;
          font-size: 14px;
        }
        window#waybar {
          background-color: #${base00};
          border-radius: 6px;
          color: #${base05};
          opacity: 1;
          transition-property: background-color;
          transition-duration: .5s;
          margin-bottom: -7px;
        }
        window#waybar.hidden {
          opacity: 0.2;
        }
        window#hyprland-window {
          background-color: #${base00};
        }
        #workspaces,
        #mode,
        #window,
        #custom-wmname,
        #clock,
        #idle_inhibitor,
        #language,
        #pulseaudio,
        #backlight,
        #battery,
        #network,
        #tray {
          background-color: #${base01};
          padding: 0 10px;
          margin: 5px 2px 5px 2px;
          border: 1px solid rgba(0, 0, 0, 0);
          border-radius: 6px;
          background-clip: padding-box;
        }

        #workspaces button {
          background-color: #${base01};
          padding: 0 5px;
          min-width: 20px;
          color: #${base03};
        }
        #workspaces button.active {
          color: #${base06};
        }

        #battery.critical:not(.charging) {
            padding: 0 10px;
            background-color: @red;
            color: #${base00};
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
        }

        #network.disconnected {
            padding: 0 10px;
            color: #${base00};
        }

        #custom-powermenu {
            background-color: @red;
            color: #${base09};
            font-size: 15px;
            padding-right: 6px;
            padding-left: 11px;
            margin: 5px;
        }
    '';
    settings = {
      mainBar = {
        margin = "0px 0px -2px 0px";
        layer = "top";
        #position = "left";

        modules-left = ["custom/wmname" "hyprland/workspaces" ];
        modules-center = [];
        modules-right = ["battery" "backlight" "pulseaudio" "clock" "network" "tray"];

      /* Modules configuration */
      "hyprland/workspaces" = {
          active-only = "false";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          disable-scroll = "false";
          all-outputs = "true";
          format = "{icon}";
          on-click = "activate";
          format-icons = {
              "1" =  "o";
              "2" =  "o";
              "3" =  "o";
              "4" =  "o";
              "5" =  "o";
              "6" =  "o";
              "7" =  "o";
              "8" =  "o";
              "9" =  "o";
              "10" = "o";
            };
          };

        "idle_inhibitor" = {
          format = "{icon}";
          format-icons = {
            activated = " ";
            deactivated = " ";
          };
        };

        "tray" = {
          spacing = 8;
        };

        "clock" = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
	        format = " {:%H:%M}";
	        format-alt = " {:%A, %B %d, %Y}";
        };

        "backlight" = {
          format = "{icon}{percent}%";
          format-icons = ["󰃞 " "󰃟 " "󰃠 "];
          on-scroll-up = "light -A 1";
          on-scroll-down = "light -U 1";
        };
        "battery" = {
          states = {
          warning = "30";
          critical = "15";
        };
          format = "{icon}{capacity}%";
          tooltip-format = "{timeTo} {capacity}%";
          format-charging = "󱐋{capacity}%";
          format-plugged = " ";
          format-alt = "{time} {icon}";
          format-icons = ["  " "  " "  " "  " "  "];
        };
        "network" = {
          format-wifi = "  {signalStrength}%";
          format-ethernet = "{ifname}: {ipaddr}/{cidr}  ";
          format-linked = "{ifname} (No IP)  ";
          format-disconnected = "󰤮 Disconnected";
          on-click = "kitty nmtui";
          tooltip-format = "{essid} {signalStrength}%";
        };

        "pulseaudio" = {
          format = "{icon}{volume}% {format_source}";
          format-bluetooth = "{icon} {volume}%";
          format-bluetooth-muted = "   {volume}%";
          format-source = "";
          format-source-muted = "";
          format-muted = "  {format_source}";
          format-icons = {
              headphone = " ";
              hands-free = " ";
              headset = " ";
              phone = " ";
              portable = " ";
              car = " ";
              default = [" " " " " "];
          };
          tooltip-format = "{desc} {volume}%";
          on-click = "pavucontrol";
        };

        "custom/wmname" = {
          format = " ";
          on-click = "rofi -show window";
        };
      };
    };
  };
}

