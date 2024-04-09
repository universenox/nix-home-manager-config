{ pkgs, inputs, ... }:
{
  # this for "shell" also includes the very many cli utils I like c:
  imports = [ ./shell_aliases_fns.nix ];

  # prompt
  programs.starship.enable = true;
  home.file.".config/starship.toml".source = ./starship.toml;

  home = {
    sessionVariables = {
      EDITOR = "hx";
      VISUAL = "hx";
    };

    packages = with pkgs; [
      lnav # log navigator, amazing.
      ripgrep
      fd       # find alt
      tree
      sd # sed alt
      lsd # ls alt
      choose # cut alt
      hyperfine # time alt
      huniq 

      python311Packages.pygments # some stuff uses it in zsh..
      grc

      timewarrior
      taskwarrior
      buku # bookmarks
      lazygit
      btop

      ranger # cli file browser
      file # optional dep of ranger
      fastfetch

      nixpkgs-fmt
      nix-tree
      shellcheck
      shfmt

      tokei # count LoC
      tealdeer # tldr alt

      gdu # du alt
      jq # json
      glow # render markdown in cli
      miller # like jq but for any tabular
      zip
      openssl
      socat
      # ascii # ascii table; some OS come with one already.
    ];
  };
  programs = {
    atuin.enable = true; # cmd history
    fzf = {
      enable = true;
      tmux.enableShellIntegration = true;
    };
    bat.enable = true;
    nix-index.enable = true; # nix-locate <cmd> to see what provides it
    less.enable = true;
    zoxide.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    lesspipe.enable = false; # pita
    helix.enable = true;
    bash.enable = true;
    tmux = {
      enable = true;
      keyMode = "vi";
      mouse = true;
      tmuxinator.enable = true; # sessions
      escapeTime = 0;
      terminal = "xterm-256color";
      shell = "${pkgs.zsh}/bin/zsh";
      extraConfig = "";
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      sessionVariables = {
        ZSH_AUTOSUGGEST_STRATEGY = [ "history" "completion" ];
        SHELL = "zsh";
      };

      initExtra = ''
        bindkey '^ ' autosuggest-accept
        # put comment after cmd to help find it in history?
        setopt interactivecomments

        # export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

        # suggestions from fzf-tab  
        zstyle ':completion:*:descriptions' format '[%d]'
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        zstyle ':completion:*' menu no
        # zstyle ':fzf-tab:*' switch-group '<' '>'      

        zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
        zstyle ':fzf-tab:complete:*:*' fzf-preview \
        'if test -d $realpath; then 
          lsd --color=always $realpath 
         else 
          bat --paging=never --color=always --style=plain $realpath 
         fi'
        zstyle ':fzf-tab:complete:*:*' fzf-flags '--height=90%'
        zstyle ':fzf-tab:*' popup-min-size 500 500

        zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
            '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
        zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

        zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
        zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color=always $realpath'
        zstyle ':fzf-tab:complete:tldr:argument-1' fzf-preview 'tldr --color always $word'

        # git
        zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word | delta'
        zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log --color=always $word'
        zstyle ':fzf-tab:complete:git-help:*' fzf-preview 'git help $word | bat -plman --color=always'
        zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
        	'case "$group" in
        	"commit tag") git show --color=always $word ;;
        	*) git show --color=always $word | delta ;;
        	esac'
        zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
        	'case "$group" in
        	"modified file") git diff $word | delta ;;
        	"recent commit object name") git show --color=always $word | delta ;;
        	*) git log --color=always $word ;;
        	esac'
      '';
      plugins =
        let
          mkPlugin = name: {
            name = "${name}";
            file = "${name}.plugin.zsh";
            src = inputs."zplug-${name}";
          };
        in
        [
          (mkPlugin "nix-zsh-completions")
          (mkPlugin "nix-shell")
          (mkPlugin "fast-syntax-highlighting")
          (mkPlugin "you-should-use")
          (mkPlugin "fzf-source")
          (mkPlugin "fzf-tab")
        ];
    };
  };
}
