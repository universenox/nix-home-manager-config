{ pkgs, home-id, ... }:
let common_initextra = ''
      # functions
      cl() { cd "$1" && la; }

      # TODO: this is kinda shitty if output is large; doesn't follow tail, idk why
      ninja() { command ninja "$@" | bat -l make --paging=never --style=plain; }
      mk_blank_pdf() { convert xc:none -page Letter blank.pdf; }
      pdf_append_blank_page() {  ${pkgs.pdftk}/bin/pdftk A="$1" B=blank.pdf cat A1-end B1-end output - ; }
      latexify_md() {
        in="$1";
        out="$2";
        test -f "$in"  || (echo "invalid input. expect latexify_md <in-file> <out-file>." && exit 1);
        test -f "$out"  || (echo "invalid input. expect latexify_md <in-file> <out-file>." && exit 1);
        pandoc  "$in" --from markdown+tex_math_dollars+tex_math_single_backslash+lists_without_preceding_blankline -o "$out";
      }
      mkcd() {
        test -d "$1" && echo "directory $1 already existed.  Entering it...";
        test -d "$1" || mkdir -p "$1";
        test -d "$1" && cd "$1";
      }
      routes() {
          ip -d -j route show table all | jq '(.[][] | arrays) |= tostring' | mlr --j2p unsparsify then reorder -f dst,gateway,dev,prefsrc,scope,table,type,metric,protocol;
      }
      yl() { ( cd ~/Music/ && yt-dlp -f 140 --no-playlist "$1"; ) }
      html_to_pdf() { chromium --headless --no-sandbox --disable-gpu --print-to-pdf "$1"; }
      glow() { "${pkgs.glow}/bin/glow "$1" -p bat"; }

      repo_size() {
        part="$1" # owner/repo
        in_kilobytes=$(curl -sG "https://api.github.com/repos/$part" | jq '.size')
        in_MB=$(( in_kilobytes / 1024 ))
        echo "$in_MB MB"
      }

      # for when nix creates symlinks but i wanna try playing around with it 
      # outside of nix for quicker iterations
      replace_symlink(){
        file="$1"
        cp "$file" "$file-tmp"
        rm "$file"
        mv $file-tmp $file
        chmod uaog+rwx $file
      }
''; in
{
  programs.bash.initExtra = common_initextra;
  programs.zsh.initExtra  = common_initextra;

  home.shellAliases = 
  {
    cat   = ''${pkgs.bat}/bin/bat --no-paging --style="changes,header,header-filename,header-filesize,snip"'';
    catp  = ''${pkgs.bat}/bin/bat --no-paging --plain''; 
    less  = ''${pkgs.bat}/bin/bat --style=auto'';
    lessp = ''${pkgs.bat}/bin/bat --plain'';
    uniq  = ''${pkgs.huniq}/bin/huniq'';
    rm    = "rm -rf";

    # a deleted one in a recurrence = failed
    # else completed = success
    # `habit`
    # `habit delete 1`
    # `habit complete 1`
    habit = "task rc.data.location=~/.habit";

    run           = "rofi -show drun";
    emoji         = "rofi -show emoji"; # emojis broken.
    window        = "rofi -show window";

    cdr           = "cd $(git rev-parse --show-toplevel)";
    ls            = "${pkgs.lsd}/bin/lsd";

    igrep         = ''${pkgs.ripgrep}/bin/rg -i'';

    # copied from https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/common-aliases
    l       = "ls -lFh";
    la      = "ls -lAFh";
    lr      = "ls -lRFh";
    lt      = "ls -ltFh";
    ll      = "ls -l";
    ldot    = "ls -ld .*";
    lS      = "ls -l1FSsh .*"; # size
    lart    = "ls -1Fart"; # modif date oldest first
    lrt     = "ls -1Frt"; # modif date
    lsr     = "ls -lARFh"; # all recursive
    lsn     = "ls -1";  # one col

    dud     = "du -d 1 -h";
    duf     = "du -sh";
    t       = "tail -f";

    o       = "xdg-open";
    hms     = "home-manager switch --flake ~/.config/home-manager/#${home-id}";
    weather = "curl wttr.in/London";
  };
}
