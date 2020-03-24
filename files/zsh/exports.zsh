if type nvim >/dev/null 2>/dev/null; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi
export MYSQL_PS1="mysql  \d  \R:\m:\s  "
export VIRTUAL_ENV_DISABLE_PROMPT=1

if [ -e "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" --no-use
fi

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && . $HOME/.tmuxinator/scripts/tmuxinator || true
