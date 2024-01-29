alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias vi='vim'
# alias ll='ls -l --color'
# alias ls='ls --color'
# alias ls='exa --icons'
function ls() {
  if [[ $1 == "-ltr" ]]; then
    exa -ls modified --icons
  else
    exa --icons $@
  fi
}
alias ll='exa -l --icons'
alias lg='exa -l --icons --git --header'
alias ltr='exa -l -s modified --icons'
alias tree='exa -l --tree --icons'

alias mk='mkdir -p'
alias mkdir='mkdir -p'

alias gc='git commit -m'
alias gs='git status'

alias bcl='bc -l'
alias grep='grep --color=auto -I --exclude-dir={.git,.svn,CMakeFiles}'
alias egrep='egrep --color=auto -I --exclude-dir={.git,.svn,CMakeFiles}'

alias m='make -j8'

if grep -q gentoo /etc/os-release 2> /dev/null; then
    alias equ='equery use'
    alias eql='equery list'
    alias eqf='equery files'
    alias eqd='equery depends'
    alias eqb='equery belongs'
    alias eqh='equery hasuse'
fi

mkf() { mkdir -p $1; cd $_ }
goto() { [[ -d $1 ]] && cd $1 || cd $(dirname $1) }

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

bak() {
    if [[ -f $1 ]]; then
        [[ -f ${1}.bak ]] && bak ${1}.bak
        cp ${1} ${1}.bak
    fi
}

f(){
    find . -name .git -prune -o -name .svn -prune -o -name CMakeFiles -prune -o -name .c    onda -prune -o -name .cquery -prune -o -name .cquery_cache -prune -o -name opt -prune -o     $@ -print | fzf -m 
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
    local result="$(fr "$@")"
    if [ "x$result" != "x" ]; then
        ${EDITOR:-vim} $(awk -F: '{ printf "+%s %s", $2, $1 }' <<< $result)
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

upload() {
    curl -F "f:1=@$1" ix.io
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
