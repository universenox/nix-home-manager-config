{ pkgs, lib, home-id, ... }:
{
  home.shellAliases = {
    cat = "${pkgs.bat}/bin/bat --paging=never";
    catp = "${pkgs.bat}/bin/bat --no-paging --plain";
    less = "${pkgs.bat}/bin/bat";
    lessp = "${pkgs.bat}/bin/bat --plain";

    run = "rofi -show drun";
    emoji = "rofi -show emoji"; # emojis broken.
    window = "rofi -show window";

    which = "type -a";
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

    zsh-abbr = {
      enable = true;
      # home-manager doesn't support global, but global is meh since 
      # the actual plugin doesn't do expansion after `$(`. use zsh's shellGlobalAliases instead.
      abbreviations = {
        "g"="git";
        "git co"="git checkout";
        "git cm"="git commit";
        "git s"="git status";
        "git a"="git add -A";
        "git d"="git diff";
        "git wip"=''git commit -m "WIP"'';
      };
    };

    # so then you can do ie ''la $(fdd F)'' or ''cat $(fdf F)''.
    # fzf-tab just searches the first depth, vs this.
    shellGlobalAliases = {
        fdd   ="fd -t d";
        fdf   ="fd -t f";
        fdcpp ="fd -e hpp -e h -e c -e cpp";
        F     =" | fzf";
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
      routes () {
          ip -d -j route show table all | jq '(.[][] | arrays) |= tostring' | mlr --j2p unsparsify then reorder -f dst,gateway,dev,prefsrc,scope,table,type,metric,protocol
      }
    ''
    +
    lib.optionalString (home-id == "legion") ''
      function ylm () { ${pkgs.yt-dlp}/bin/yt-dlp -f 139 $1 } 
    '';
  };
}
