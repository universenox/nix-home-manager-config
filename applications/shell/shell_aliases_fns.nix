{ pkgs, lib, home-id, ... }:
{
  home.shellAliases = {
    cat = "${pkgs.bat}/bin/bat --paging=never";
    catp = "${pkgs.bat}/bin/bat --no-paging --plain";
    less = "${pkgs.bat}/bin/bat";
    lessp = "${pkgs.bat}/bin/bat --plain";


    which = "type -a";
    find = ''${pkgs.fd}/bin/fd'';
    la = "ls -a";
    cdr = "cd $(git rev-parse --show-toplevel)";
    ls = "${pkgs.lsd}/bin/lsd";

    o = "xdg-open";
    hms = "home-manager switch --flake ~/.config/home-manager/#${home-id}";
    weather = "curl wttr.in/London";
  };

  programs.zsh = {
    shellAliases = { 
      cppshell = "nd ~/.config/home-manager/applications/shell/devShells/cpp";
      pyshell  = "nd ~/.config/home-manager/applications/shell/devShells/python";
    };

    shellGlobalAliases = {
      # so then you can do ie ''vim fd F'' or ''cat ff F''.
      # fzf-tab doesn't search ALL dirs at a time, which can be either good/bad.
      fdir = ''find -t d'';
      ff = ''find -t f'';
      fcpp = ''find -e hpp -e h -e c -e cpp'';
      F = " | fzf";
    };

    zsh-abbr = {
      enable = true;

      abbreviations = {
        g = "git";
        "git co" = "git checkout";
        "git cm" = "git commit";
        "git staash" = "git stash --all";
        "git s" = "git status";
        "git a" = "git add -A";
        "git wip" = ''git commit -m "WIP"'';
        "git d" = ''git diff'';
      };
    };

    initExtra = ''
      # functions
      function nd() {
        nix develop $1 --command zsh
      }
      function cl() {
        cd $1 && la
      }
      function mkcd() {
        test -d "$1" && echo "directory $1 already existed.  Entering it..."
        test -d "$1" || mkdir -p "$1"
        test -d "$1" && cd "$1"
      }
    ''
    +
    lib.optionalString (home-id == "legion") ''
      function ylm () { ${pkgs.yt-dlp}/bin/yt-dlp -f 139 $1 } 
    '';
  };
}
