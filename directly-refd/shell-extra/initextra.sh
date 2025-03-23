SCRIPT_DIR=$(dirname $0)

export REFERENCE_NIXPKGS=$HOME/.shell-extra/reference_nixpkgs.lock
export PATH=${PATH}:$HOME/bin

source ${SCRIPT_DIR}/funcs.sh
source ${SCRIPT_DIR}/aliases.sh

if [[ $(basename $SHELL) == "zsh" ]]; then
  source ${SCRIPT_DIR}/zsh-extra.zsh
fi
