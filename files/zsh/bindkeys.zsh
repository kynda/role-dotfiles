bindkey -e ## Default to standard emacs bindings

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# M-. let's me grab the last argument on the previous line.  M-m let's me cycle through them.
autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "^[m" copy-earlier-word

autoload -U select-word-style
select-word-style bash

# Fix Home/End on Centos
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey "${terminfo[kpp]}" up-line-or-history
bindkey "${terminfo[knp]}" down-line-or-history
bindkey "^?" backward-delete-char
bindkey "^[[3~" delete-char
