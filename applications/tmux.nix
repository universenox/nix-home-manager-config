{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    mouse = true;
    clock24 = true;
    historyLimit = 20000;
    escapeTime = 0;
    terminal = "tmux-256color";
    shell = "${pkgs.zsh}/bin/zsh";
    customPaneNavigationAndResize = true;

    # prefix + ctrl+s/r to save/restore
    plugins = with pkgs.tmuxPlugins; [
      resurrect
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
        '';
      }
    ];

    extraConfig = ''
      # DESIGN TWEAKS
      # don't do anything when a 'bell' rings
      set -g visual-activity off
      set -g visual-bell off
      set -g visual-silence off
      setw -g monitor-activity off
      set -g bell-action none

      # clock mode
      setw -g clock-mode-colour colour5

      # copy mode
      setw -g mode-style 'fg=colour0 bg=colour15 bold'

      # pane borders
      set -g pane-border-style 'fg=colour5'
      set -g pane-active-border-style 'fg=colour3'

      # statusbar
      set -g status-position top
      set -g status-justify left
      set -g status-style 'fg=colour12'
      set -g status-left ''\''
      set -g status-right '%Y-%m-%d %H:%M '
      set -g status-right-length 50
      set -g status-left-length 10

      setw -g window-status-current-style 'fg=colour0 bg=colour4 bold'
      setw -g window-status-current-format ' #I #W #F '

      setw -g window-status-style 'fg=colour4 '
      setw -g window-status-format ' #I #[fg=colour7]#W #[fg=colour4]#F '

      setw -g window-status-bell-style 'fg=colour2 bg=colour4 bold'
      # messages
      set -g message-style 'fg=colour2 bg=colour0 bold'
    '';
  };
}
