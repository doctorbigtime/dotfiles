# .zshrc
DEFAULT_USER=sfortas

# source all config files.
if [ -d $HOME/.zsh ]; then
    for f in $(ls $HOME/.zsh/*.zsh 2> /dev/null)
    do
        source $f
    done
fi
[ -f $HOME/.dircolors ] && eval `dircolors $HOME/.dircolors`
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /home/sfortas/git/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
    source /home/sfortas/git/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 

. ~/git/z/z.sh

# misc stuff.

# enable directory stack
DIRSTACKSIZE=8
setopt autopushd pushdminus pushdsilent pushdignoredups
setopt autocd

setopt interactivecomments

# history
HISTFILE=~/.zsh_history
HISTSIZE=1024
SAVEHIST=1024
setopt append_history
unsetopt share_history
unsetopt inc_append_history

# i want my core files
ulimit -c unlimited

set -o vi
export KEYTIMEOUT=1

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/sfortas/opt/google-cloud-sdk/path.zsh.inc' ]; then . '/home/sfortas/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/sfortas/opt/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/sfortas/opt/google-cloud-sdk/completion.zsh.inc'; fi
