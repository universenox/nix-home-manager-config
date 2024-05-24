{ lib, nix-colors, ...}:
{
  options.colors = with lib; {
    enable = true;
    colorScheme = mkOption { 
      type = with types; attrs; 
      default = nix-colors.colorSchemes.gruvbox-material-dark-soft; 
      # default = nix-colors.colorSchemes.tokyo-city-terminal-light; 
      description = "colorscheme";
    };   
  };
  config.programs.helix.settings.theme = "base16-gruvbox-material-dark-soft";
  # config.programs.helix.settings.theme = "base16-tokyo-city-terminal-light";

  config.home.sessionVariables = {
    # BAT_THEME = "gruvbox-light"; # `bat --list-themes`
    BAT_THEME = "gruvbox-dark"; # `bat --list-themes`
  };
}
