{ pkgs, lib, home-id, ... }:
{
  home.shellAliases = {
    cat = "${pkgs.bat}/bin/bat --paging=never";
    catp = "${pkgs.bat}/bin/bat --no-paging --plain";
    less = "${pkgs.bat}/bin/bat";
    lessp = "${pkgs.bat}/bin/bat --plain";
    uniq = "${pkgs.huniq}/bin/huniq";

    run = "rofi -show drun";
    emoji = "rofi -show emoji"; # emojis broken.
    window = "rofi -show window";

    which = "type -a";
    cdr = "cd $(git rev-parse --show-toplevel)";
    ls = "${pkgs.lsd}/bin/lsd";

    # copied from https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/common-aliases
    l = "ls -lFh";
    la = "ls -lAFh";
    lr = "ls -lRFh";
    lt = "ls -ltFh";
    ll = "ls -l";
    ldot = "ls -ld .*";
    lS = "ls -l1FSsh .*"; # size
    lart = "ls -1Fcart"; # modif date oldest first
    lrt = "ls -1Fcrt"; # modif date
    lsr = "ls -lARFh"; # all recursive
    lsn = "ls -1";  # one col

    dud = "du -d 1 -h";
    duf = "du -sh";
    t = "tail -f";

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

        F     =" | fzf";
        T     =" | tail";
        H     =" | head";
        "LL"  ="2>&1 | less";
        "CA"  ="2>&1 | cat -A";
        "NE"  ="2 > /dev/null";
        "NUL"  ="2 > /dev/null";
      };
    };

    # so then you can do ie ''la $(fdd F)'' or ''cat $(fdf F)''.
    # fzf-tab just searches the first depth, vs this.
    shellGlobalAliases = {
        fdd   ="fd -t d";
        fdf   ="fd -t f";
        fdcpp ="fd -e hpp -e h -e c -e cpp";
    };

    initExtra = ''
      # functions
      function nd() {
        nix develop $1 --command zsh
      }
      function latexify_md() {
        in="$1"
        out="$2"
        test -f $in   || (echo "invalid input. expect latexify_md <in-file> <out-file>." && exit 1)
        test -f $out  || (echo "invalid input. expect latexify_md <in-file> <out-file>." && exit 1)

        # idk.
        pandoc $in --from markdown+tex_math_dollars+tex_math_single_backslash+lists_without_preceding_blankline -o $out
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
