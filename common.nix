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
      ripgrep
      btop
      fd # find alt
      sd # sed alt
      lsd # ls alt
      choose # cut alt
      gdu # du alt
      jq # json
      socat
      openssl
      mkpasswd

      lnav # log navigator, looks promising.

      shellcheck
      shfmt

      tree
      nix-tree

      xclip

      tokei # count LoC
      tealdeer # tldr alt

      buku # bookmarks
      taskwarrior
      timewarrior

      ranger # cli file browser
      file # optional dep of ranger

      nixpkgs-fmt
      fastfetch
      hack-font

      # fira needed for emojis on `lsd`
      fira-code
      fira-code-symbols
      fira-code-nerdfont
    ];
  };

  programs = {
    atuin.enable = true; # cmd history
    fzf.enable = true;
    bat.enable = true;
    nix-index.enable = true; # nix-locate <cmd> to see what provides it
    less.enable = true;
    zoxide.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
