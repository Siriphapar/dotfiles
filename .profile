# set up PATH
PORT_PATH=/opt/local/bin:/opt/local/sbin
SYS_PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin
NODE_PATH=/usr/local/node-v0.8.19/bin
export PATH=$NODE_PATH:$PORT_PATH:/usr/local/mysql/bin:$SYS_PATH:~/bin

# set up MAN_PATH
SYS_MAN_PATH=/usr/share/man:/usr/local/share/man:/opt/X11/share/man
NODE_MAN_PATH=/usr/local/node-v0.8.19/share/man
PORT_MAN_PATH=/opt/local/share/man
MYSQL_MAN_PATH=/usr/local/mysql/man
export MANPATH=$NODE_MAN_PATH:$PORT_MAN_PATH:$MYSQL_MAN_PATH:/usr/local/share/man:

# for run-tests.sh script
export NGSERVER_DIR=/Users/emeinfelder/src/ngCore-Server/ngCore
export GIT_EDITOR=/usr/bin/vim
export SVN_EDITOR=/usr/bin/vim
export CLICOLOR=1
export JAVA_HOME=/Library/Java/Home
export CLASSPATH=.:/usr/local/apache-log4j-1.2.16/log4j-1.2.16.jar
export LD_LIBARY_PATH=/opt/local/lib:/usr/local/lib:/usr/lib
export NEO4J_HOME=/Users/edmond/neo4j-community-1.6.1

# see man ls for color info
export LSCOLORS="GxfxcxdxBxegedabagacad"

# Define some colors first:
# Has the same effect as using "ansi.sys" in DOS.
FG_BLACK='\[\e[1;30m\]'
FG_BOLD_RED='\[\e[1;31m\]'
FG_RED='\[\e[0;31m\]'
FG_BOLD_GREEN='\[\e[1;32m\]'
FG_GREEN='\[\e[0;32m\]'
FG_BOLD_YELLOW='\[\e[1;33m\]'
FG_YELLOW='\[\e[0;33m\]'
FG_BOLD_BLUE='\[\e[0;34m\]'
FG_BLUE='\[\e[0;34m\]'
FG_BOLD_MAGENTA='\[\e[1;35m\]'
FG_MAGENTA='\[\e[0;35m\]'
FG_BOLD_CYAN='\[\e[1;36m\]'
FG_CYAN='\[\e[0;36m\]'
FG_BOLD_WHITE='\[\e[1;37m\]'
FG_WHITE='\[\e[0;37m\]'
FG_GRAY="\[\033[0;37m\]"

BG_BLACK='\[\e[1;40m\]'
BG_RED='\[\e[1;41m\]'
BG_GREEN='\[\e[1;42m\]'
BG_YELLOW='\[\e[1;43m\]'
BG_BLUE='\[\e[1;44m\]'
BG_MAGENTA='\[\e[1;45m\]'
BG_CYAN='\[\e[1;46m\]'
BG_WHITE='\[\e[1;47m\]'

BOLD='\[\e[1\]'
FAINT='\[\e[2\]'
ITALIC='\[\e[2\]'
NORMAL='\[\e[22\]'
UNDERLINE_ON='\[\e[2\]'
UNDERLINE_OFF='\[\e[24\]'
RESET='\[\e[0;39m\]'
NOCOLOR='\[\e[0m\]'              # No Color

function parse_git_branch {

  git rev-parse --git-dir &> /dev/null
  git_status="$(git status 2> /dev/null)"

  remote_pattern="# Your branch is (.*) of"
  diverge_pattern="# Your branch and (.*) have diverged"
  not_staged="# Changes not staged for commit:"
  branch_pattern="^# On branch ([^${IFS}]*)"
  untracked_files="# Untracked files:"

  state="";

  if [[ ${git_status} =~ "nothing to commit (working directory clean)" ]]; then
    state="${state} ✓"
  fi

  if [[ ${git_status} =~ ${not_staged} ]]; then
    state="${state} ✗"
  fi

  if [[ ${git_status} =~ ${untracked_files} ]]; then
    state="${state} ✚"
  fi

  # add an else if or two here if you want to get more specific
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      state="${state} ↑"
    else
      state="${state} ↓"
    fi
  fi

  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    state="${state} ↑↓"
  fi

  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
    echo -e "(${branch})${state}"
  fi
}

PS1="${FG_BOLD_WHITE}\w ${FG_YELLOW}\$(parse_git_branch)${RESET} $ "

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
alias du='du -kh'
alias df='df -kTh'

# The 'ls' family (this assumes you use the GNU ls)
alias la='ls -AlG'          # show hidden files
alias ls='ls -hF -G'        # add colors for filetype recognition
alias lx='ls -lXBG'         # sort by extension
alias lk='ls -lSrG'         # sort by size
alias lc='ls -lcrG'         # sort by change time
alias lu='ls -lurG'         # sort by access time
alias lr='ls -lRG'          # recursive ls
alias lt='ls -ltrG'         # sort by date
alias lm='ls -alG |more'    # pipe through 'more'
alias tree='tree -Csu'      # nice alternative to 'ls'
alias l='ls -hF -G'
alias countjs="find . -name "*.js" -exec cat \{\} \; | wc -l"

# spelling typos - highly personnal :-)
alias xs='cd'
alias vf='cd'
alias moer='more'
alias moew='more'
alias apache='cd /opt/local/apache2';

function vi()    { echo -e "\033];$@\007"; vim $@; echo -e "\033];\007"; }
function vp()    { vi `grep "$@" * | cut -f1 -d: | sort -u`; }
function vcpp()  { vi `grep "$@" *.cpp *.h | cut -f1 -d: | sort -u`; }
function vjs()   { vi `grep "$@" *.js | cut -f1 -d: | sort -u`; }
function vp2()   { vi `grep "$@" *.php *.inc | cut -f1 -d: | sort -u`; }
function rgrep   { find . -exec grep -iHn "$@" \{\} \;; }
function fvi()   { find . -name "$@" -exec vi \{\} \; ; }
function pjson() { echo $@ | python -mjson.tool ; }
function vijs()  { vi `grep --include='*.js' -nr "$@"  | cut -d: -f1 | sort -u` ; }

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
