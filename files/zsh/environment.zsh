export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export TERM=xterm-256color

export FZF_CTRL_R_OPTS="--inline-info --exact"

[ "$ITERM_PROFILE" = 'Light' ] && export PRIMARY_FG=white

# Solarize Dircolors
if whence dircolors >/dev/null; then
    eval `dircolors $HOME/.dircolors`
    alias ls="ls --color=always"
    alias grep="grep --color=always"
else
    export CLICOLOR=1
    zstyle ':completion:*:default' list-colors ''
fi

if whence keychain >/dev/null; then
    eval `keychain --agents ssh id_rsa`
fi

[ -e "$HOME/.go" ] && export GOPATH="$HOME/.go"
[ -e "/usr/local/go" ] && export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"
[ -e "$HOME/.cask/bin/" ] && export PATH="$PATH:$HOME/.cask/bin/"
[ -e "$HOME/.rvm/bin/" ] && export PATH="$HOME/.rvm/bin:$PATH" # Add RVM to PATH for scripting

if [ -d "/usr/local/bin" ] ; then
    PATH="$PATH:/usr/local/bin"
fi

if [ -d "$HOME/.cargo/bin" ] ; then
    PATH="$PATH:$HOME/.cargo/bin"
    DISPLAY=:0
fi

if [ -d "/opt/Postman" ] ; then
    PATH="$PATH:/opt/Postman"
fi

if [ -d "$HOME/bin" ] ; then
    PATH="$PATH:$HOME/bin"
fi

if [ -d "$HOME/.yarn/bin" ] ; then
    PATH="$PATH:$HOME/.yarn/bin"
fi
