# enable directory stack
setopt autopushd

# prompt
autoload -U colors && colors

if [[ $terminfo[colors] -ge 256 ]]; then
    purple="%F{135}"
    white="%F{144}"
    red="%F{161}"
    blue="%F{81}"
    green="%F{118}"
    orange="%F{208}"
else
    purple="%F{magenta}"
    white="%F{white}"
    red="%F{red}"
    blue="%F{blue}"
    green="%F{green}"
    orange="%F{yellow}"
fi

local op="${white}[%f"
local cp="${white}]%f"
local path_p="${op}${purple}%~${cp}"
local context="${op}${blue}%m${cp}"
local smiley="%(?,${green}:%)%f,${red}:(%f)"

prompt_vcs() {
    local PL_BRANCH_CHAR=$'\ue0a0' # 
    local PL_TAG_CHAR=$'\u2691' # 

    setopt promptsubst
    autoload -Uz vcs_info
    zstyle ':vcs_info:*' enable git svn

    if $(git rev-parse --is-inside-work-tree > /dev/null 2>&1); then
        dirty=$(git status --porcelain)
        ref=$(git symbolic-ref HEAD 2> /dev/null) || ref=" $PL_TAG_CHAR $(git describe --tags --exact-match 2> /dev/null)" || ref=" ➦ $(git rev-parse --short HEAD 2> /dev/null)"
        if [[ -n $dirty ]]; then
            color=$orange
        else
            color=$green
        fi
        zstyle ':vcs_info:*' stagedstr "✚"
        zstyle ':vcs_info:*' unstagedstr "●"
        zstyle ':vcs_info:*' check-for-changes true
        zstyle ':vcs_info:*' formats  ' %u%c'
        zstyle ':vcs_info:*' actionformats  ' %u%c %a'
        vcs_info
        echo -n "─[${color}${ref/refs\/heads\// $PL_BRANCH_CHAR }${vcs_info_msg_0_}%f]"
    elif svn info > /dev/null 2>&1; then
        zstyle ':vcs_info:svn:*' branchformat "%b:${red}%r"
        zstyle ':vcs_info:svn:*' formats ' %b '
        vcs_info
        [[ -n ${vcs_info_msg_0_} ]] && echo -n "─[${vcs_info_msg_0_}%f]"
    fi
}

setopt prompt_subst
PROMPT='%{$reset_color%}╭─${context}─${path_p}$(prompt_vcs)%{$reset_color%}
╰─${op}${smiley}${cp} %# '

