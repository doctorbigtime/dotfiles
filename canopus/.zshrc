setopt interactivecomments
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
unset LS_COLORS
# [ -f $HOME/.dircolors ] && eval `dircolors $HOME/.dircolors`
export EXA_COLORS="*.cc=00;38;5;245:*.cpp=00;38;5;245:*.h=00;38;5;245:*.hpp=00;38;5;245:*.c=00;38;5;245:*.rs=00;38;5;245"

zshsh=/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f $zshsh ] && source $zshsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f $HOME/git/z/z.sh ] && source ~/git/z/z.sh
[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

fpath=($HOME/.zsh/completions $fpath)
compinit

export KEYTIMEOUT=1

export PATH=$HOME/bin:$HOME/.local/bin:$PATH
