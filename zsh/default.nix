{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    oh-my-zsh = {
      enable = true;
    };
    shellAliases = {
      reload = "source ~/.zshrc";
      edit-profile = "nvim ~/.zshrc";
      nd = "nix develop --command zsh";
    };
    sessionVariables = {
      SPACESHIP_PROMPT_ADD_NEWLINE = "false";
      SPACESHIP_PROMPT_SEPARATE_LINE = "false";

      SPACESHIP_DIR_COLOR = "182";
      SPACESHIP_GIT_BRANCH_COLOR = "217";

      SPACESHIP_CHAR_COLOR_SUCCESS = "225";
      SPACESHIP_CHAR_COLOR_FAILURE = "124";
      SPACESHIP_CHAR_COLOR_SECONDARY = "229";

      SPACESHIP_GIT_STATUS_SHOW = "false";

      ZSH_AUTOSUGGEST_STRATEGY = [ "history" ];
      SPACESHIP_NIXSHELL_SHOW = "\${SPACESHIP_NIXSHELL_SHOW=true}";
      SPACESHIP_NIXSHELL_PREFIX = "\${SPACESHIP_NIXSHELL_PREFIX=\"nix-shell \"}";
      SPACESHIP_NIXSHELL_SUFFIX = "\${SPACESHIP_NIXSHELL_SUFFIX=\"$SPACESHIP_PROMPT_DEFAULT_SUFFIX\"}";
      SPACESHIP_NIXSHELL_SYMBOL = "\${SPACESHIP_NIXSHELL_SYMBOL=\"❄️\"}";
    };
    initExtra = ''
      bindkey '^ ' autosuggest-accept
    '';
    plugins = [
      {
        name = "spaceship-prompt";
        file = "spaceship.zsh-theme";
        #src = plugin-spaceship-prompt;
        src = pkgs.fetchFromGitHub {
          owner = "spaceship-prompt";
          repo = "spaceship-prompt";
          rev = "v3.16.1";
          sha256 = "sXnL57g5e7KboLXHzXxSD0+8aKPNnTX6Q2yVft+Pr7w=";
        };
      }
      {
        name = "nix-zsh-completions";
        file = "nix-zsh-completions.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "spwhitt";
          repo = "nix-zsh-completions";
          rev = "468d8cf752a62b877eba1a196fbbebb4ce4ebb6f";
          sha256 = "16r0l7c1jp492977p8k6fcw2jgp6r43r85p6n3n1a53ym7kjhs2d";
        };
      }
      {
        # provides special arg suggestions for commands like git, ...
        name = "fzf-tab";
        file = "fzf-tab.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "190500bf1de6a89416e2a74470d3b5cceab102ba";
          sha256 = "1dipsy0s67fr47ig5559bcp1h5yn8rdjshhs8zsq7j8plvvh99qb";
        };
      }
      {
        name = "nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.4.0";
          sha256 = "037wz9fqmx0ngcwl9az55fgkipb745rymznxnssr3rx9irb6apzg";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        file = "zsh-syntax-highlighting.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "caa749d030d22168445c4cb97befd406d2828db0";
          sha256 = "sha256-YV9lpJ0X2vN9uIdroDWEize+cp9HoKegS3sZiSpNk50=";
        };
      }
    ];
  };
}
