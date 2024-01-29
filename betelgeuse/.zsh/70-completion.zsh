# autocomplete
setopt complete_in_word
setopt always_to_end
setopt path_dirs
setopt auto_menu
setopt auto_list
unsetopt menu_complete
unsetopt flowcontrol

# use caching
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path ~/.cache/zsh

zstyle ':completion:*' special-dirs true

zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*:options' description true
zstyle ':completion:*:options' auto-description 'specify: %d'
zstyle ':completion:*:corrections' format '%F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
zstyle ':completion:*' verbose true

# case insensitive search
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,args -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:kill:*' force-list always

zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# pick image files first, if fail, pick all files.
#zstyle ':completion:*:*:pinta:*' file-patterns '*.(jpg|JPG|gif|GIF|png|PNG):image-files' '%p:all-files'


autoload -Uz compinit
compinit
