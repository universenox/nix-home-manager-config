
source $HOME/.shell-extra/common_init.sh

nd() { nix develop "$1" --command zsh; }

# global aliases.
alias -g fdd="fd -t d"
alias -g fdf="fd -t f"
alias -g fdcpp="fd -e hpp -e h -e c -e cpp"
alias -g F=" | fzf"
alias -g T=" | tail"
alias -g H=" | head"

# remove nix/store/hash- prefix
alias -g unnix="sd '/nix/store/(.*)?-(.*?):' '\$2' "

alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2 > /dev/null"
alias -g NUL="2 > /dev/null"


bindkey '^ ' autosuggest-accept
# put comment after cmd to help find it in history?
setopt interactivecomments

# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# suggestions from fzf-tab  
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
# zstyle ':fzf-tab:*' switch-group '<' '>'      

zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:complete:*:*' fzf-preview \
'if test -d $realpath; then 
  lsd --color=always $realpath 
 else 
  bat --paging=never --color=always --style=plain $realpath 
 fi'
zstyle ':fzf-tab:complete:*:*' fzf-flags '--height=90%'
zstyle ':fzf-tab:*' popup-min-size 500 500

zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
    '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color=always $realpath'
zstyle ':fzf-tab:complete:tldr:argument-1' fzf-preview 'tldr --color always $word'

# git
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff $word | delta'
zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log --color=always $word'
zstyle ':fzf-tab:complete:git-help:*' fzf-preview 'git help $word | bat -plman --color=always'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
	'case "$group" in
	"commit tag") git show --color=always $word ;;
	*) git show --color=always $word | delta ;;
	esac'
zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
	'case "$group" in
	"modified file") git diff $word | delta ;;
	"recent commit object name") git show --color=always $word | delta ;;
	*) git log --color=always $word ;;
	esac'

# start into the one tmux session 
function to_mux(){
	if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
		cd $HOME
		# creates one tmux group; all new shells will start attached to this (shares windows, but not dup)
    tmux new-session -t main >/dev/null 2>&1
	fi      
}

