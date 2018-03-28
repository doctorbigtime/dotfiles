autoload -U colors && colors

autoload -Uz vcs_info

local sep=$'\ue0b0'

local col1=49
local col2=37
local col3=239

local fg1="%{[38;5;${col1}m%}"
local fg2="%{[38;5;${col2}m%}"
local fg3="%{[38;5;${col3}m%}"
local bg1="%{[48;5;${col1}m%}"
local bg2="%{[48;5;${col2}m%}"
local bg3="%{[48;5;${col3}m%}"

local color1="%{[38;5;49m%}"
local color2="%{[38;5;37m%}"
local bgcolor1="239"
local bgcolor2="49"
local color3="%{[38;5;${bgcolor1}m%}"
local arrow="${color3}${sep}"
local smiley="%(?,%{$fg[green]%}:%),%{$fg[red]%}:()"

zstyle ':vcs_info:*' stagedstr '%F{green}●'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git svn
theme_precmd () {
    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
        zstyle ':vcs_info:*' formats ' %b%c%u%B%F{white}'
    } else {
        zstyle ':vcs_info:*' formats ' %b%c%u%B%F{red}●%F{white}'
    }

    vcs_info
}

setopt prompt_subst
PROMPT='%B${bg3}${fg1}%m${bg2}${fg3}${sep}${fg3}%d${bg3}${fg2}${sep}${vcs_info_msg_0_}%{$reset_color%}${fg3}${sep}
${bg3}${smiley}%F{white} %%%{$reset_color%}${arrow}%{$reset_color%}'

autoload -U add-zsh-hook
add-zsh-hook precmd  theme_precmd

HISTFILE=~/.zsh_history
HISTSIZE=1024
SAVEHIST=1024
setopt append_history
unsetopt share_history
unsetopt inc_append_history
