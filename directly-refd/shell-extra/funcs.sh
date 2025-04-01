# functions
cl() { cd "$1" && la; }

mkcd() {
  test -d "$1" && echo "directory $1 already existed.  Entering it...";
  test -d "$1" || mkdir -p "$1";
  cd "$1" || echo "directory $1 does not exist.";
}

routes() {
    ip -d -j route show table all | \
      jq '(.[][] | arrays) |= tostring' | \
      mlr --j2p 'unsparsify then reorder' -f dst,gateway,dev,prefsrc,scope,table,type,metric,protocol;
}

yl() { ( cd ~/Music/ && yt-dlp -f 140 --no-playlist "$1"; ) }

html_to_pdf() { chromium --headless --no-sandbox --disable-gpu --print-to-pdf "$1"; }

repo_size() {
  part="$1" # owner/repo
  in_kilobytes=$(curl -sG "https://api.github.com/repos/$part" | jq '.size')
  in_MB=$(( in_kilobytes / 1024 ))
  echo "$in_MB MB"
}

read_linux_ts(){
  local nanoseconds=$1
  local seconds=$((nanoseconds / 1000000000 ))
  local nanoseconds_remainder=$((nanoseconds % 1000000000 ))
  date -d "@$seconds" +"+Y-%m-%d %H:%M:%S.$(printf '%09d' $nanoseconds_remainder)"
}
