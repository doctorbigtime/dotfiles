setopt complete_in_word
setopt always_to_end
setopt path_dirs
setopt auto_menu
setopt auto_list
unsetopt menu_complete
unsetopt flowcontrol

_find_pid() {
  RBUFFER=$(awk '{print $2}' < <(ps -usfortas -f | fzf -m --header-lines=1 --border))
}
zle -N _find_pid
bindkey '^p' _find_pid

_paste_xclip() {
  RBUFFER=$(xclip -o)
}
zle -N _paste_xclip
bindkey '^v' _paste_xclip

# use caching
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path ~/.cache/zsh

zstyle ':completion:*' special-dirs true

zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' verbose true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# case insensitive search
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*:options' description true
zstyle ':completion:*:options' auto-description 'specify: %d'
zstyle ':completion:*:corrections' format '%F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'

# cd
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# kill
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,args -w"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z]#)*=01;34;=0=01'
zstyle ':completion:*:*:kill:*' force-list always

zstyle ':completion:*' hosts localhost ny4dm2s01 ny2pm2s02 dinesh aurpm2s03 ny4spare01

autoload -Uz compinit
compinit

