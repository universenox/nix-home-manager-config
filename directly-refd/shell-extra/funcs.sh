# functions
cl() { cd "$1" && la; }

# TODO: this is kinda shitty if output is large; doesn't follow tail, idk why
# ninja() { command ninja "$@" | bat -l make --paging=never --style=plain; }
 
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
  cd "$1" || echo "directory $1 does not exist.";
}

routes() {
    ip -d -j route show table all | jq '(.[][] | arrays) |= tostring' | mlr --j2p unsparsify then reorder -f dst,gateway,dev,prefsrc,scope,table,type,metric,protocol;
}

yl() { ( cd ~/Music/ && yt-dlp -f 140 --no-playlist \"$1\"; ) }

html_to_pdf() { chromium --headless --no-sandbox --disable-gpu --print-to-pdf "$1"; }

repo_size() {
  part="$1" # owner/repo
  in_kilobytes=$(curl -sG "https://api.github.com/repos/$part" | jq '.size')
  in_MB=$(( in_kilobytes / 1024 ))
  echo "$in_MB MB"
}

export PATH=$PATH:$HOME/.hm_scripts
export REFERENCE_NIXPKGS=$HOME/.hm_scripts/reference_nixpkgs.lock
