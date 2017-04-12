autoload -U colors && colors

autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '%F{green}●'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git svn
theme_precmd () {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats ' [%b%c%u%B%F{white}]'
    } else {
        zstyle ':vcs_info:*' formats ' [%b%c%u%B%F{red}●%F{white}]'
    }

    vcs_info
}

vim_ins_mode="[%F{yellow}I%{$reset_color%}]"
vim_cmd_mode="[%F{cyan}C%{$reset_color%}]"
vim_mode=$vim_ins_mode

function zle-keymap-select {
   vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
   zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
   vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

setopt prompt_subst
PROMPT='%B%F{white}[%{[38;5;49m%}%m%F{white}:%{[38;5;37m%}%d%F{white}]${vcs_info_msg_0_}%B%F{yellow} %{$reset_color%} $vim_mode
%% '

autoload -U add-zsh-hook
add-zsh-hook precmd  theme_precmd

HISTFILE=~/.zsh_history
HISTSIZE=1024
SAVEHIST=1024
setopt append_history
unsetopt share_history
unsetopt inc_append_history
