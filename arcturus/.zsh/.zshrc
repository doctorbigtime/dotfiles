HISTFILE=~/.zsh_history
HISTSIZE=1024
SAVEHIST=1024

setopt append_history
unsetopt share_history
unsetopt inc_append_history
autoload -U colors && colors

autoload -Uz vcs_info

CURRENT_BG='NONE'

() {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    SEGMENT_SEPARATOR=$'\ue0b0'
}

segment() {
    local bg fg
    [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
    [[ -n $1 ]] && fg="%F{$2}" || fg="%f"
    if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
        echo -n "%{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
    else
        echo -n "%{$bg%}%{$fg%} "
    fi
    CURRENT_BG=$1
    [[ -n $3 ]] && echo -n $3
}

prompt_context() {
   segment 13 white '%B%m%b'
}

prompt_virtualenv() {
    local venv_path="$VIRTUAL_ENV"
    if [[ -n $ven_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
        segment blue white "(`basename $venv_path`)"
    fi
}

prompt_dir() {
    segment magenta white '%~'
}

prompt_vcs() {
    local PL_BRANCH_CHAR
    () {
        local LC_ALL="" LC_CTYPE="en_US.UTF-8"
        PL_BRANCH_CHAR=$'\ue0a0' # 
    }
    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git svn
    if $(git rev-parse --is-inside-work-tree > /dev/null 2>&1); then
        dirty=$(git status --porcelain)
        ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
        if [[ -n $dirty ]]; then
            segment yellow black
        else
            segment blue white
        fi
        zstyle ':vcs_info:*' stagedstr '✚'
        zstyle ':vcs_info:*' unstagedstr '●'
        zstyle ':vcs_info:*' check-for-changes true
        zstyle ':vcs_info:*' get-revision true
        zstyle ':vcs_info:*' formats ' %u%c'
        zstyle ':vcs_info:*' actionformats ' %u%c %a'
        vcs_info
        echo -n "${ref/refs\/heads\//$PL_BRANCH_CHAR }${vcs_info_msg_0_}"
    else
        if svn info >/dev/null 2>&1; then
            zstyle ':vcs_info:svn:*' formats '%b'
            #dirty=$(svn status -q)
            #if [[ -n $dirty ]]; then
            #    segment yellow black
            #else
            segment green black
            #fi
            vcs_info
            echo -n "${vcs_info_msg_0_}"
        fi
    fi
}

prompt_status() {
    local symbols
    symbols=()
    [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
    [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
    [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"
    symbols+="%%"
    segment 13 white "$symbols"
}

prompt_end() {
    if [[ $CURRENT_BG != 'NONE' ]]; then
        echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
    else
        echo -n "%{%k%}"
    fi
    echo -n "%{%f%}"
    CURRENT_BG='NONE'
    [[ -n $1 ]] && echo ""
}

build_prompt() {
    RETVAL=$?
    prompt_virtualenv
    prompt_context
    prompt_dir
    prompt_vcs
    prompt_end crlf
    prompt_status
    prompt_end
}

setopt prompt_subst
if [[ "$TERM" == "linux" ]];
then
    PROMPT='[%F{blue}%B%n%b%f@%M][%~]
%# '
else
    PROMPT='%{%f%b%k%}$(build_prompt) '
fi
[[ -f ${HOME}/.env ]] && source ${HOME}/.env
[[ -f ${HOME}/.alias ]] && source ${HOME}/.alias
[[ -f $HOME/.dircolors ]] && eval `dircolors $HOME/.dircolors`
ulimit -c unlimited
#export TERM="xterm-256color"

