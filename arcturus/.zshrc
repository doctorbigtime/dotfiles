setopt interactive_comments
DIRSTACKSIZE=8
setopt autopushd pushdminus pushdsilent pushdignoredups
setopt autocd
ulimit -c unlimited
set -o vi

HISTFILE=~/.zsh_history
HISTSIZE=1024
SAVEHIST=1024
setopt append_history
unsetopt share_history
unsetopt inc_append_history

if [ -d $HOME/.zsh ]; then
    for f in $HOME/.zsh/*.zsh
        source $f
fi
[ -f $HOME/.dircolors ] && eval `dircolors $HOME/.dircolors`

zshsh=/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f $zshsh ] && source $zshsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

fpath=($HOME/.zsh/completions $fpath)
compinit

export KEYTIMEOUT=1

