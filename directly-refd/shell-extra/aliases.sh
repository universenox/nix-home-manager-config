alias cat="bat --no-paging --style=changes,header,header-filename,header-filesize,snip"
alias catp="bat --no-paging --plain"
alias less="bat --style=auto"
alias lessp="bat --plain"
alias uniq=huniq
alias tree="tree --gitignore"
alias treei="command tree"
alias rm="rm -rf"

alias run="rofi -show drun"
alias emoji="rofi -show emoji"; # emojis broken.
alias window="rofi -show window"

alias cdr='cd $(git rev-parse --show-toplevel)'
alias ls=lsd

alias dud="du -d 1 -h"
alias duf="du -sh"
alias t="tail -f"
alias o="xdg-open"
alias hms="home-manager switch --flake $HOME/.config/home-manager/#${HM_HOME_ID}"
alias weather="curl wttr.in/London"
alias rs="openrussian"

# copied from https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/common-aliases
alias l="ls -lFh"
alias la="ls -lAFh"
alias lr="ls -lRFh"
alias lt="ls -ltFh"
alias ll="ls -l"
alias ldot="ls -ld .*"
alias lS='ls -- -l1FSsh .*' # size
alias lart="ls -1Fart" # modif date oldest first
alias lrt="ls -1Frt" # modif date
alias lsr="ls -lARFh" # all recursive
alias lsn="ls -1"  # one col
