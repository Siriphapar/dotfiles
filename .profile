# set up PATH
export PORT_PATH=/opt/local/bin:/opt/local/sbin
export SYS_PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin
export NODE_PATH=/usr/local/node-v0.8.19/bin
export PATH=$NODE_PATH:$PORT_PATH:/usr/local/mysql/bin:$SYS_PATH:~/bin

# set up MAN_PATH
export NODE_MAN_PATH=/usr/local/node-v0.8.19/share/man
export PORT_MAN_PATH=/opt/local/share/man
export MYSQL_MAN_PATH=/usr/local/mysql/man
export MANPATH=$NODE_MAN_PATH:/usr/local/share/man:$PORT_MAN_PATH:$MYSQL_MAN_PATH

# for run-tests.sh script
export NGSERVER_DIR=/Users/emeinfelder/src/ngCore-Server/ngCore

export GIT_EDITOR=/usr/bin/vim
export SVN_EDITOR=/usr/bin/vim

export CLICOLOR=1
export JAVA_HOME=/Library/Java/Home
export CLASSPATH=.:/usr/local/apache-log4j-1.2.16/log4j-1.2.16.jar
export LD_LIBARY_PATH=/opt/local/lib:/usr/local/lib:/usr/lib
export NEO4J_HOME=/Users/edmond/neo4j-community-1.6.1

# a     black
# b     red
# c     green
# d     brown
# e     blue
# f     magenta
# g     cyan
# h     light grey
# A     bold black, usually shows up as dark grey
# B     bold red
# C     bold green
# D     bold brown, usually shows up as yellow
# E     bold blue
# F     bold magenta
# G     bold cyan
# H     bold light grey; looks like bright white
# x     default foreground or background

# 1.   directory 			                            Gx
# 2.   symbolic link		                            fx
# 3.   socket 				                            cx
# 4.   pipe				                            	dx
# 5.   executable			                            Bx
# 6.   block special		                            eg
# 7.   character special	                            ed
# 8.   executable with setuid bit set	                ab
# 9.   executable with setgid bit set	                ag
# 10.  directory writable to others, with sticky bit	ac
# 11.  directory writable to others, without sticky bit	ad

LSCOLORS="GxfxcxdxBxegedabagacad"
export LSCOLORS

# Define some colors first:
# Has the same effect as using "ansi.sys" in DOS.

FG_BLACK='\e[1;30m'
FG_BOLD_RED='\e[1;31m'
FG_RED='\e[0;31m'
FG_BOLD_GREEN='\e[1;32m'
FG_GREEN='\e[0;32m'
FG_BOLD_YELLOW='\e[1;33m'
FG_YELLOW='\e[0;33m'
FG_BOLD_BLUE='\e[0;34m'
FG_BLUE='\e[0;34m'
FG_BOLD_MAGENTA='\e[1;35m'
FG_MAGENTA='\e[0;35m'
FG_BOLD_CYAN='\e[1;36m'
FG_CYAN='\e[0;36m'
FG_BOLD_WHITE='\e[1;37m'
FG_WHITE='\e[0;37m'
RESET='\e[0;39m'
NOCOLOR='\e[0m'              # No Color

BG_BLACK='\e[1;40m'
BG_RED='\e[1;41m'
BG_GREEN='\e[1;42m'
BG_YELLOW='\e[1;43m'
BG_BLUE='\e[1;44m'
BG_MAGENTA='\e[1;45m'
BG_CYAN='\e[1;46m'
BG_WHITE='\e[1;47m'

BOLD='\e[1'
FAINT='\e[2'
ITALIC='\e[2'
NORMAL='\e[22'
UNDERLINE_ON='\e[2'
UNDERLINE_OFF='\e[24'

function _git_prompt() {
    local git_status="`git status -unormal 2>&1`"
    if ! [[ "$git_status" =~ Not\ a\ git\ repo ]]; then
        if [[ "$git_status" =~ nothing\ to\ commit ]]; then
            local ansi=42
            #local ansi=32
        elif [[ "$git_status" =~ nothing\ added\ to\ commit\ but\ untracked\ files\ present ]]; then
            local ansi=43
        else
            #local ansi=45
            local ansi=41
        fi
        if [[ "$git_status" =~ On\ branch\ ([^[:space:]]+) ]]; then
            branch=${BASH_REMATCH[1]}
            test "$branch" != master || branch=' '
        else
            # Detached HEAD.  (branch=HEAD is a faster alternative.)
            branch="(`git describe --all --contains --abbrev=4 HEAD 2> /dev/null ||
                echo HEAD`)"
        fi
        echo -n '\[\e[0;37;'"$ansi"';1m\]'"$branch"'\[\e[0m\] '
    fi
}

function parse_git_branch {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "("${ref#refs/heads/}")"
}

#export PS1="${FG_RED}\h ${FG_BOLD_WHITE}\w${RESET}: "
#export PS1="\h \w: "
#export PS1="\w: "
#export PS1="\[${FG_WHITE}\]\w\[${RESET}\] $ "
#PS1="\w \$(parse_git_branch)\$ "
#export PS1="\e[37;40m\w\e[0m % "
export PS1="\[${FG_BOLD_WHITE}\]\w \[${FG_YELLOW}\]$(parse_git_branch)\[${RESET}\] $ "

# Looks best on a black background.....
#echo -e "${FG_WHITE}This is BASH ${FG_RED}${BASH_VERSION%.*}${FG_WHITE} - DISPLAY on ${FG_RED}$DISPLAY${RESET}\n\n"

alias sb='source ~/.profile'
alias vb='vi ~/.profile'

alias mkdir='mkdir -p'
alias python='python2.6'

alias h='history'
alias j='jobs -l'
alias which='type -all'
alias path='echo -e ${PATH//:/\\n}'
alias printn='/usr/bin/lp -o nobanner -d $LPDEST'   # Assumes LPDEST is defined
alias pjet='enscript -h -G -fCourier9 -d $LPDEST'  # Pretty-print using enscript
#alias background='xv -root -quit -max -rmode 5'    # Put a picture in the background
alias du='du -kh'
alias df='df -kTh'

function vp() { vi `grep "$@" *.cpp *.h | cut -f1 -d: | sort -u`; }

# The 'ls' family (this assumes you use the GNU ls)
alias la='ls -AlG'          # show hidden files
alias ls='ls -hF -G'	    # add colors for filetype recognition
alias lx='ls -lXBG'         # sort by extension
alias lk='ls -lSrG'         # sort by size
alias lc='ls -lcrG'		    # sort by change time  
alias lu='ls -lurG'		    # sort by access time   
alias lr='ls -lRG'          # recursive ls
alias lt='ls -ltrG'         # sort by date
alias lm='ls -alG |more'    # pipe through 'more'
alias tree='tree -Csu'		# nice alternative to 'ls'
alias l='ls -hF -G'

# spelling typos - highly personnal :-)
alias xs='cd'
alias vf='cd'
alias moer='more'
alias moew='more'

# aliases for moblyng
alias apache='cd /opt/local/apache2';
function vi() { echo -e "\033];$@\007"; vim $@; echo -e "\033];\007"; }
function vp() { vi `grep "$@" * | cut -f1 -d: | sort -u`; }
function vcpp() { vi `grep "$@" *.cpp *.h | cut -f1 -d: | sort -u`; }
function vjs() { vi `grep "$@" *.js | cut -f1 -d: | sort -u`; }
function vp2() { vi `grep "$@" *.php *.inc | cut -f1 -d: | sort -u`; }
function rgrep { find . -exec grep -iHn "$@" \{\} \;; }
function fvi() { find . -name "$@" -exec vi \{\} \; ; }
function pjson() { echo $@ | python -mjson.tool ; }
function vijs() { vi `grep --include='*.js' -nr "$@"  | cut -d: -f1 | sort -u` ; }

# work-specific aliases
alias grepjsi="grep --include='*.js' -inrc "
alias grepjs="grep --include='*.js' -nrc "
alias grepc="grep --include='*.h' --include='*.c' -nirc "
alias work="cd /Users/emeinfelder/src/ngCore-Server/ngCore"
alias src="cd /Users/emeinfelder/src/ngCore-Server/ngCore/src/core"
alias test="cd /Users/emeinfelder/src/ngCore-Server/ngCore/test/core"
alias exam="cd /Users/emeinfelder/src/ngCore-Server/examples"
alias dp="cd ~/src/ngCore-Server/ngCore/src/core/generators/templates/defaultProject"
alias src2="cd ~/src"
alias ts="cd ~/src/TestServer"
alias ng="ngServer"
alias makeng="npm install; npm link ngServer"
alias ngnew="ng new --name=TestServer; cd TestServer; npm install; npm link ngServer"

alias countjs="find . -name "*.js" -exec cat \{\} \; | wc -l"

