{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-gtk3;
  };
  home.packages = [ pkgs.emacs-all-the-icons-fonts ];

  home.shellAliases = {
    emacsclientnw = ''emacsclient -nw -c -a "" ''; # within terminal
    emacsclient = ''emacsclient -c -a ""'';
  };
}
