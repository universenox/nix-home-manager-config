{ lib, config, pkgs, ... }:
{
  imports = [ ./rofi ./kitty ];
  home = {
    shellAliases = {
      list-fonts = "fc-list";
      e = "hx";

      ls = "lsd";
      cat = "bat --paging=never";
      catp = "bat --no-paging --plain";

      # screenshot
      ss = "grim -g \"$(slurp -d)\" - | swappy -f -"
        };
      sessionVariables = {
        TERMINAL = "kitty";
        EDITOR = "hx";
        VISUAL = "hx";
      };
      packages = with pkgs; [
        ripgrep
        btop
        fd # find alt
        sd # sed alt
        gh # cli github
        lsd # ls alt
        xclip
        hexyl

        ranger # cli file browser, but hmm, fzf...
        file # opt dep of ranger

        wl-clipboard # for helix yank to system clipboard
        wayshot # todo: would like alternative.
      ];

      # for nix-direnv
      file.".env".text = ''
        use nix
        use flake
      '';
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
      lazygit.enable = true;
      less.enable = true;
      zoxide.enable = true;
      autojump.enable = true;
    };
  }
