# Simple aliases
alias l="ls -lhF"
alias ll="ls -alhF"
alias "tree"="tree -C"
alias xclip="xclip -selection c"
alias less="less -R"
alias colors="source colors"

# Neovim
if type nvim >/dev/null 2>/dev/null; then
  alias vim=nvim
fi

# Git Aliases
alias g='git'

alias gr='[ ! -z `git rev-parse --show-toplevel` ] && cd `g rev-parse --show-toplevel || pwd`'
alias gb='g branch'

alias gd='g diff'
alias gdc='gd --cached'

alias ga='g add'
alias gap='ga -p'

alias gc='g commit --verbose'
alias gca='gc --amend'

alias gco='g checkout'

alias gl='g log'
alias gll='g ll'

alias gs='g status'
alias gsp='g show -p'

alias gp='g pull'
alias gpr='gp --rebase'

alias gra='g rebase --abort'
alias grc='g rebase --continue'

alias gP='g push'
alias gm='g merge'

alias gg='g grep'

alias gst='g stash'
alias gstl='gst list'
alias gstd='gst drop'
alias gstp='gst pop'
alias gsta='gst apply'
alias gsts='gst save'
alias gstsu='gsts -u'

alias ghp="git reset --soft HEAD~1" # Git Hard Pop

# Docker Aliases
alias dkr-exec='docker exec -e COLUMNS="`tput cols`" -e LINES="`tput lines`" -it --detach-keys "ctrl-q,q" '
alias dkr-run='docker run -it --detach-keys "ctrl-q,q" '
alias dkr-stats="docker stats \$(docker ps --format '{{.Names}}')"

# Tmux Shortcut
alias tmux='tmux -2 -u'
alias muxa="tmux a -t"
alias muxn="tmux new -s"
alias muxls="tmux ls"
alias muxk="tmux kill-session -t"
alias "tmux a"="tmux a -t"
alias "tmux n"="tmux new -s"

# See you space cowboy
alias exit="$HOME/bin/seeyouspacecowboy.sh; sleep 2; exit"
