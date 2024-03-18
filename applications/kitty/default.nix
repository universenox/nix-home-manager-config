{ config, ... }:
{
  home.sessionVariables = {
    GLFW_IM_MODULE = "ibus"; # enable working with fcitx5 switching JP/EN keyb
  };

  programs.kitty = with config.colorScheme.palette; {
    enable = true;
    settings = {
      #-------- Font --------
      font_family      = "Fira Code";
      italic_font      = "Fira Code Italic";
      bold_font        = "Fira Code Bold";
      bold_italic_font = "Fira Code Bold Italic";
      size = 12;
      symbol_map = "U+E0A0-U+E0A3,U+E0C0-U+E0C7 PowerlineSymbols";
      
      # adapt from https://github.com/kdrag0n/base16-kitty/blob/master/templates/default-256.mustache
      #-------- Color --------
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

      #-------- Etc --------
      #scrollback_pager= "less ";"+G -R
      cursor_shape= "beam";
      cursor_blink_interval    = "0.7";
      cursor_stop_blinking_after= "15.0";
      
      enable_audio_bell    = false;
      visual_bell_duration = "0.0";
      bell_on_tab          = "🔔 ";
      
      # Characters considered part of a word when double clicking.
      select_by_word_characters = '':@-./";"_~?&=%+#'';
      mouse_hide_wait           = "0.0";
      enabled_layouts           = "*";
      
      remember_window_size  = "no";
      initial_window_width  = "640";
      initial_window_height = "400";
      
      repaint_delay   = "10";
      input_delay= "3";
      
      # $TERM
      term               = "xterm-kitty";
      window_border_width= "5";
      window_margin_width= "0";

      scrollback_lines        = "10000";
      wheel_scroll_multiplier = "5.0";
      click_interval          = "0.5";

      open_url_modifiers      = "ctrl+shift";
      open_url_with           = "default";

      confirm_os_window_close = "1";
      #hide_window_decorations = "titlebar-only";
    };

    keybindings = {
      # http://www.glfw.org/docs/latest/group__keys.html
      # http://www.glfw.org/docs/latest/group__mods.html
      # no_op

      # Clipboard
      "super+v"      = "paste_from_clipboard";
      "ctrl+shift+s" = "paste_from_selection";
      "super+c"      = "copy_to_clipboard";
      "shift+insert" = "paste_from_selection";

      # Scrolling
      "ctrl+shift+up"         = "scroll_line_up";
      "ctrl+shift+down"       = "scroll_line_down";
      "ctrl+shift+k"          = "scroll_line_up";
      "ctrl+shift+j"          = "scroll_line_down";
      "ctrl+shift+page_up"    = "scroll_page_up";
      "ctrl+shift+page_down"  = "scroll_page_down";
      "ctrl+shift+home"       = "scroll_home";
      "ctrl+shift+end"        = "scroll_end";
      "ctrl+shift+h"          = "show_scrollback";

      # Window management
      "ctrl+shift+enter" = "new_window";
      "ctrl+shift+]" = "next_window";
      "ctrl+shift+[" = "previous_window";
      "ctrl+shift+f" = "move_window_forward";
      "ctrl+shift+b" = "move_window_backward";
      "ctrl+shift+`" = "move_window_to_top";
      "ctrl+shift+1" = "first_window";
      "ctrl+shift+2" = "second_window";
      "ctrl+shift+3" = "third_window";
      "ctrl+shift+4" = "fourth_window";
      "ctrl+shift+5" = "fifth_window";
      "ctrl+shift+6" = "sixth_window";
      "ctrl+shift+7" = "seventh_window";
      "ctrl+shift+8" = "eighth_window";
      "ctrl+shift+9" = "ninth_window";
      "ctrl+shift+0" = "tenth_window";

      # Tab management
      "ctrl+shift+right" =  "next_tab";
      "ctrl+shift+left" =  "previous_tab";
      "ctrl+shift+t" =  "new_tab";
      "ctrl+shift+q" =  "close_tab";
      "ctrl+shift+l" =  "next_layout";
      "ctrl+shift+." =  "move_tab_forward";
      "ctrl+shift+," =  "move_tab_backward";

      # Miscellaneous
      "ctrl+shift+=" = "increase_font_size";
      "ctrl+shift+-" = "decrease_font_size";
      "ctrl+shift+backspace" = "restore_font_size";
    };
  };
}
