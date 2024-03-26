# common across all configurations
{ pkgs, nix-colors, ... }:
{
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  imports = [
    ./applications/kitty
    ./applications/git
  ];
  #### colors ####
  colorScheme = nix-colors.colorSchemes.gruvbox-material-dark-soft;
  programs.helix.settings.theme = "base16-gruvbox-material-dark-soft";
  programs.kitty.theme = "Gruvbox Material Dark Soft";
  ###############

  home = {
    stateVersion = "23.11"; # no touchy
    keyboard.layout = "us";

    packages = with pkgs; [
      hack-font
      # fira needed for emojis on `lsd`
      fira-code
      fira-code-symbols
      fira-code-nerdfont

      vscode # apparently has a great MR-resolver / git utils; must check out.
      xclip
    ];
  };

  programs = {};
}
