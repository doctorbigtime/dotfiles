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
eval `dircolors`
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 
[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

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

# ROS
#source /opt/ros/melodic/setup.zsh
source /home/pi/ros2_foxy/install/setup.zsh

