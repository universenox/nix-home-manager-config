# for stuff to share between work and home.
{ lib, config, pkgs, nix-colors, atuin, helix-base16-themes, ... }:
let 
  #tokyo-night-storm;
  theme = "gruvbox-material-dark-soft";
in
{
  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
  fonts.fontconfig.enable = true;

  imports = [
    ./kitty
    ./rofi
    ./timers.nix
  ];
  # https://tinted-theming.github.io/base16-gallery/
  colorScheme = nix-colors.colorSchemes.${theme}; 

  services.syncthing = {
      enable = true;
      tray.enable = true;
  };
 
  home = {
    stateVersion = "23.11"; # no touchy
    keyboard.layout = "us";

    shellAliases = {
      which="type -a";
      cat =  "${pkgs.bat}/bin/bat --paging=never";
      catp = "${pkgs.bat}/bin/bat --no-paging --plain";
      cppshell = let file = ./devShells/cpp; in "nix develop ${file}";
      ls = "${pkgs.lsd}/bin/lsd";

      # local_ips = ''${pkgs.nmap}/bin/nmap -sL "192.168.66.0.*" | grep \(1"''
    };

    sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
    };

    packages = with pkgs; [
      ripgrep
      btop
      fd     # find alt
      sd     # sed alt
      lsd    # ls alt
      xclip

      jira-cli-go # looks promising.

      (python311.withPackages (p: with p; [
        bugwarrior
      ]))

      tree
      nix-tree

      shellcheck
      shfmt

      buku     # bookmarks
      tokei    # count LoC
      tealdeer # tldr alt
      taskwarrior 
      timewarrior
      
      ranger # cli file browser
      file   # optional dep of ranger

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


  home.file.".config/helix/themes/".source = "${helix-base16-themes}/themes/";
  programs = {
    helix = {
      enable = true;
      defaultEditor = true;
      settings.theme = "base16-${theme}";

      settings.editor = {
        rulers = [80 120];
      };
      languages = 
        [
          { name = "cpp"; auto-format = true; }
        ];
    };
    bash.enable = true;
    atuin.enable=true; # cmd history
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
      ignores = [ "*~" "*.swp" "*.sync-conflict*" ".stfolder*" ];
    };
  };
}
