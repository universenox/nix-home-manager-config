{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-gtk3;
  };
  home.packages = [ pkgs.emacs-all-the-icons-fonts ];
}
