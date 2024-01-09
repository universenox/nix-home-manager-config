{ lib, config, pkgs, ... }:
{
  home.sessionVariables = {
    GLFW_IM_MODULE = "ibus"; # enable working with fcitx5 switching JP/EN keyb
  };
  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
      bell_on_tab = "🔔 ";
      scrollback_lines = 10000;
      font_family = "Noto";
      symbol_map = "U+E0A0-U+E0A3,U+E0C0-U+E0C7 PowerlineSymbols";

      # nix-colors theme
      foreground = "#${config.colorScheme.colors.base05}";
      background = "#${config.colorScheme.colors.base00}";
    };
  };
}
