# TODO: this is kinda shitty if output is large; doesn't follow tail, idk why
# ninja() { command ninja "$@" | bat -l make --paging=never --style=plain; }
 
mk_blank_pdf() { convert xc:none -page Letter blank.pdf; }

pdf_append_blank_page() {  pdftk A="$1" B=blank.pdf cat A1-end B1-end output - ; }

latexify_md() {
  in="$1";
  out="$2";
  test -f "$in"  || (echo "invalid input. expect latexify_md <in-file> <out-file>." && exit 1);
  test -f "$out"  || (echo "invalid input. expect latexify_md <in-file> <out-file>." && exit 1);
  pandoc  "$in" --from markdown+tex_math_dollars+tex_math_single_backslash+lists_without_preceding_blankline -o "$out";
}

yl() { ( cd ~/Music/ && yt-dlp -f 140 --no-playlist "$1"; ) }

html_to_pdf() { chromium --headless --no-sandbox --disable-gpu --print-to-pdf "$1"; }

if [[ $(cat /proc/$$/comm) == "zsh" ]]; then
  # start into the one tmux session
  if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
    cd "$HOME" || true
		# creates one tmux group; all new shells will start attached to this (shares windows, but not dup)
    tmux new-session -t main >/dev/null 2>&1
  fi      
fi
