{ lib, nix-colors, ...}:
let
  # --- light theme ---
  # light kinda shit `ls`
  # cs = "gruvbox-material-light-hard";
  # bat = "gruvbox-light";
  # --- dark theme ---
  cs = "gruvbox-material-dark-soft";
  bat = "gruvbox-dark";
  # ------------------
  helix = "base16-${cs}";
in {
  options.colors = with lib; {
    enable = true;
    colorScheme = mkOption { 
      type = with types; attrs; 
      default = nix-colors.colorSchemes.${cs}; 
      description = "colorscheme";
    };   
  };
  config.programs.helix.settings.theme = helix;
  config.programs.bat.config.theme = bat;
}
