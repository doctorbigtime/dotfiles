zmodload -i zsh/complist

unsetopt menu_complete
unsetopt flowcontrol

setopt auto_menu
setopt complete_in_word
setopt always_to_end

zstyle ':completion:*' menu select
# case insensitive search
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z]#)*=01;34;=0=01'

# process selection list
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

zstyle ':completion::complete:*' use-cache true
