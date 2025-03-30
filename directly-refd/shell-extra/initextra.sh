SCRIPT_DIR=$(dirname $0)

export REFERENCE_NIXPKGS=$HOME/.shell-extra/reference_nixpkgs.lock
export PATH=$HOME/bin:$HOME/.nix-profile/bin:${PATH}

source $HOME/.shell-extra/funcs.sh
source $HOME/.shell-extra/aliases.sh

export HISTSIZE=20000

SHELL=$(cat /proc/$$/comm)
if [[ $SHELL == "zsh" ]]; then
  source ${SCRIPT_DIR}/zsh-extra.zsh
else
  shopt -s histappend
  export HISTCONTRL=ignoredups
  function nd() {
    nix develop "$1"
  }
fi

alias cppshell="nd ~/.config/home-manager/dev_shells/cpp"
alias binshell="nd ~/.config/home-manager/dev_shells/bin_debug"
alias pyshell="nd ~/.config/home-manager/dev_shells/python"

