{ lib, config, pkgs, ... }:
{
  imports = [ ./rofi ./kitty ];
  home = {
    shellAliases = {
      find = "bfs";
      list-fonts = "fc-list";

      ls = "lsd";
      cat = "bat --paging=never";
      catp = "bat --no-paging --plain";
    };
    sessionVariables = {
      EDITOR = "vim";
      TERMINAL = "kitty";
      # fzf with preview using pistol -- doesn't work
      #FZF_DEFAULT_COMMAND="fzf --preview='pistol -c ~/.pistol.conf {}' --preview-window '~3'";
    };
    packages = with pkgs; [
      ripgrep
      btop
      bfs # another find alt
      fd # find alt
      sd # sed alt
      gh # cli github
      lsd # ls alt
      xclip
      hexyl

      wayshot # todo: would like alternative.
    ];

  };
  programs = {
    bash.enable = true;
    fzf = {
      enable = true;
      enableZshIntegration = true;
      # defaultCommand = 
      # defaultOptions = 
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    bat = {
      enable = true;
      config = {
        theme = "Solarized (light)";
      };
    };
    nix-index.enable = true;
    lazygit.enable = true;
    less.enable = true;
    zoxide.enable = true;
    autojump.enable = true;

    pistol = {
      enable = true;
      associations = [
        { mime = "text/*"; command = "bat %pistol-filename%"; }
        { mime = "inode/directory"; command = "lsd %pistol-filename%"; }
        # TODO: this will fail bc kitty inside previewer gets wrong dimensions
        { mime = "image/*"; command = "kitten icat %pistol-filename%"; }
      ];
    };
  };
}
