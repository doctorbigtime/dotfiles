alias -g ..='cd ..'
alias -g ...='cd ../..'
alias -g ....='cd ../../..'
alias -g less='less -R'

alias -g H='| head'
alias -g T='| tail'
alias -g C='| wc -l'
alias -g EG='|& egrep'
alias -g L='|& less -R'
alias -g F='| fzf'

alias vi='vim'
alias ll='ls -l --color'
alias ls='ls --color'

alias mk='mkdir -p'
alias mkdir='mkdir -p'

alias gc='git commit -m'
alias gs='git status'
alias gl='git log --pretty=oneline'

alias bcl='bc -l'
alias grep='egrep --color=auto --exclude-dir={.git,.svn}'
alias egrep='egrep --color=auto --exclude-dir={.git,.svn}'

alias gp='git stash; git pull; git stash pop'

alias t='todo.sh'

mkf() { mkdir -p $1; cd $1 }
goto() { [ -d $1 ] && cd $1 || cd $(dirname $1) }

ark() {
    if [ -f $1 ]; then
        # extract
        case $1 in
            *.tar.bz2) tar xvjf $1 ;;
            *.tar.gz)  tar xvzf $1 ;;
            *.tgz)     tar xvzf $1 ;;
            *.xz)      xz -d $1 ;;
            *)         echo "Don't know what to do with $1" ;;
        esac
    else
        # create
        arch=$1; shift
        case $arch in
            *.tar.bz2) tar cvjf $arch "$@" ;;
            *.tar.gz)  tar cvzf $arch "$@" ;;
            *.xz)      xz "$@" ;;
            *.gz)      gzip "$@" ;;
            *.bz2)     bzip2 "$@" ;;
            *)         echo "Don't know how to create $arch" ;;
        esac
    fi
}

fsrc() {
    find "${@:-.}" -name CMakeFiles -prune -o -name .git -prune -o -name _\* -prune -o -print
}

c() {
    cd "$(find . -type d ! -iwholename '*.git*' ! -iwholename '*.svn*' | fzf +m -q "$1" -0)"
}   

fo() {
    read -r key file <<< $(fzf -q "$1" -0 --expect=ctrl-o,ctrl-e | tr "\n" " ")
    if [ -n "$file" ]; then
        [ "$key" = "ctrl-o" ] && mimeopen $file || ${EDITOR:-vim} $file
    else
        ${EDITOR:-vim} $key
    fi
}

fkill() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

    if [ "x$pid" != "x" ]; then
        echo $pid | xargs kill -"${1:-9}"
    fi
}

fr() {
    egrep --color=auto -I --include \*.h --include \*.cpp --include \*.hpp --include \*.c --exclude-dir={.git,.svn,.cquery} -n -r "$@" | fzf --ansi
}

fgo() {
    local result=$(fr "$@")
    if [ "x$result" != "x" ]; then
        ${EDITOR:-vim} $(awk -F: '{ printf "+%s %s", $2, $1 }' <<< $result)
        fgo $@
    fi
}

fp() {
    if grep -q debian /etc/os-release > /dev/null; then
        echo -n "$(apt-cache search "${@:-.}" \
            | fzf -m --ansi \
            | sed 's/ .*//')"
    else
        echo -n "$(pacman --color always "${@:--Ss}" \
            | sed 'N;s/\n//' \
            | fzf -m --ansi \
            | sed 's/ .*//')"
    fi
}

fip() {
    dpkg -l $@ | tail +6 | fzf -m | awk '{ print $2 }'
}

man() {
LESS_TERMCAP_mb=$'\e[0;31m' \
LESS_TERMCAP_md=$'\e[0;35m' \
LESS_TERMCAP_me=$'\e[0m' \
LESS_TERMCAP_se=$'\e[0m' \
LESS_TERMCAP_so=$'\e[01;31;31m' \
LESS_TERMCAP_ue=$'\e[0m' \
LESS_TERMCAP_us=$'\e[0;36m' \
command man "$@"
}
