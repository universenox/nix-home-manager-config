# for stuff to share between work and home.
{ lib, config, pkgs, nix-colors, ... }:
{
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  imports = [];

  # https://tinted-theming.github.io/base16-gallery/
  colorScheme = nix-colors.colorSchemes.tokyo-night-storm;
 
  home = {
    stateVersion = "23.11"; # no touchy
    keyboard.layout = "us";

    shellAliases = {
      e = "hx";
      ls = "lsd";
      cat = "bat --paging=never";
      catp = "bat --no-paging --plain";

      cppshell = let file = ./devShells/cpp; in "nix develop ${file}";
    };

    sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
    };

    packages = with pkgs; [
      ripgrep
      btop
      fd # find alt
      sd # sed alt
      lsd # ls alt
      xclip
      tree

      shellcheck
      shfmt

      ranger # cli file browser
      file # optional dep of ranger

      nixpkgs-fmt
      fastfetch

      # fonts
      noto-fonts
      noto-fonts-emoji

      # fira needed for emojis on `lsd`
      fira-code
      fira-code-symbols
      fira-code-nerdfont
    ];
 };

  programs = {
    helix = {
      enable = true;
      defaultEditor = true;
    };
    bash.enable = true;
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    bat = {
      enable = true;
    };
    nix-index.enable = true;
    lazygit.enable = true; # cute little cli for viewing git stuff
    less.enable = true;
    zoxide.enable = true;
    autojump.enable = true;
    git = {
      enable = true;
      difftastic.enable = true;

      extraConfig = { # see man git-config
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
        rerere = { #reuse recorded resolutions
          enabled = true;
          autoUpdate = true;
        };
      };
      ignores = [ "*~" "*.swp" ];
    };
  };
}
