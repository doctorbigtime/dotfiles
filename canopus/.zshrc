setopt autopushd
setopt autocd
ulimit -c unlimited
set -o vi

if [ -d $HOME/.zsh ]; then
    for f in $HOME/.zsh/*.zsh
        source $f
fi
[ -f $HOME/.dircolors ] && eval `dircolors $HOME/.dircolors`

zshsh=/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f $zshsh ] && source $zshsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
