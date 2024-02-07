# common across all configurations
{ lib, config, pkgs, nix-colors, atuin, theme, ... }:
{
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;
  colorScheme = let th = (import theme).theme; in nix-colors.colorSchemes.${th};
  imports = [ ./kitty ];


  home = {
    stateVersion = "23.11"; # no touchy
    keyboard.layout = "us";

    packages = with pkgs; [
      xclip

      tree
      nix-tree

      shellcheck
      shfmt

      tokei # count LoC
      tealdeer # tldr alt

      buku # bookmarks
      taskwarrior
      timewarrior

      ranger # cli file browser
      file # optional dep of ranger

      nixpkgs-fmt
      fastfetch
      # fonts
      # noto-fonts
      # noto-fonts-emoji
    ];
  };

  programs = {
    git = {
      enable = true;
      extraConfig = {
        # see man git-config
        branch = {
          autoSetupMerge = true;
          autoSetupRebase = "always";
          fetch = { prune = true; };
          pull = { rebase = true; };
          rebase = {
            autoSquash = true;
            autoStash = true; # before rebase, then applies after.
          };
          merge = {
            ff = "only";
            log = true;
          };
        };
        rerere = {
          # reuse recorded resolutions
          enabled = true;
          autoUpdate = true;
        };
      };
      ignores = [ "*~" "*.swp" "*.sync-conflict*" ".stfolder*" ];
    };
  };
}
