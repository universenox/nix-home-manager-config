SCRIPT_DIR=$HOME/.shell-extra
source $SCRIPT_DIR/common_init.sh

function nd() { nix develop "$1"; }

if [ -f "$SCRIPT_DIR"/module/initextra.sh ]; then
  source "$SCRIPT_DIR"/module/initextra.sh
fi
