{ lib, config, pkgs, ... }:
{
  home.sessionVariables = {
    GLFW_IM_MODULE = "ibus"; # enable working with fcitx5 switching JP/EN keyb
  };
  programs.kitty = {
    enable = true;
    settings = let colors = config.colorScheme.palette; in {
      enable_audio_bell = false;
      bell_on_tab = "🔔 ";
      scrollback_lines = 10000;
      font_family = "Noto";
      symbol_map = "U+E0A0-U+E0A3,U+E0C0-U+E0C7 PowerlineSymbols";

      # adapt from https://github.com/kdrag0n/base16-kitty/blob/master/templates/default-256.mustache
      background = "#${colors.base00}";
      foreground = "#${colors.base05}";
      selection_background = "#${colors.base05}";
      selection_foreground = "#${colors.base00}";
      url_color = "#${colors.base04}";
      cursor = "#${colors.base05}";
      active_border_color = "#${colors.base03}";
      inactive_border_color = "#${colors.base01}";
      active_tab_background = "#${colors.base00}";
      active_tab_foreground = "#${colors.base05}";
      inactive_tab_background = "#${colors.base01}";
      inactive_tab_foreground = "#${colors.base04}";
      tab_bar_background = "#${colors.base01}";
    };
  };
}
