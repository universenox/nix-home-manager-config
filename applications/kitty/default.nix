{ config, ... }:
{
  home.sessionVariables = {
    GLFW_IM_MODULE = "ibus"; # enable working with fcitx5 switching JP/EN keyb
  };

  programs.kitty = with config.colorScheme.palette; {
    enable = true;
    settings = {
      enable_audio_bell = false;
      bell_on_tab = "🔔 ";
      scrollback_lines = 10000;
      font_family = "Noto";
      size = 12;
      symbol_map = "U+E0A0-U+E0A3,U+E0C0-U+E0C7 PowerlineSymbols";

      # adapt from https://github.com/kdrag0n/base16-kitty/blob/master/templates/default-256.mustache
      background = "#${base00}";
      foreground = "#${base05}";
      selection_background = "#${base05}";
      selection_foreground = "#${base00}";
      url_color = "#${base04}";
      cursor = "#${base05}";
      active_border_color = "#${base03}";
      inactive_border_color = "#${base01}";
      active_tab_background = "#${base00}";
      active_tab_foreground = "#${base05}";
      inactive_tab_background = "#${base01}";
      inactive_tab_foreground = "#${base04}";
      tab_bar_background = "#${base01}";
    };
  };
}
