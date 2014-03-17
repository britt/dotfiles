source ~/.cinderella.profile
export PATH="/Users/bcrawford/Developer/bin:$PATH:/usr/local/bin:/usr/local/sbin:/usr/X11/bin:~/workspace/scripts:~/workspace/scripts/local:~/.rvm/bin:/Users/bcrawford/workspace/depot_tools:/Users/bcrawford/node_modules/.bin:/Users/bcrawford/Developer/share/npm/bin"
export EDITOR="subl -w"
export NODE_PATH="/Users/bcrawford/Developer/lib/node"

alias o="open"
alias topcpu='ps aux | sort -n +2 | tail -10'  # top 10 cpu processes
alias topmem='ps aux | sort -n +3 | tail -10'  # top 10 memory processes
alias duf='du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'
alias t="terminitor start $1"
alias be="bundle exec $1"
alias gti="git"
alias n="boom"
alias gs="rvm gemset use $1"
alias gh_deploy="git checkout master && git merge dev && git push && git checkout dev"

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "*"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\(\1$(parse_git_dirty)\)/"
}


bash_prompt_command() {
    # How many characters of the $PWD should be kept
    local pwdmaxlen=25
    # Indicate that there has been dir truncation
    local trunc_symbol=".."
    local dir=${PWD##*/}
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
        NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    fi
}

bash_prompt() {
    case $TERM in
     xterm*|rxvt*)
         local TITLEBAR='\[\033]0;\u:${NEW_PWD}\007\]'
          ;;
     *)
         local TITLEBAR=""
          ;;
    esac
    local NONE="\[\033[0m\]"    # unsets color to term's fg color

    # regular colors
    local K="\[\033[0;30m\]"    # black
    local R="\[\033[0;31m\]"    # red
    local G="\[\033[0;32m\]"    # green
    local Y="\[\033[0;33m\]"    # yellow
    local B="\[\033[0;34m\]"    # blue
    local M="\[\033[0;35m\]"    # magenta
    local C="\[\033[0;36m\]"    # cyan
    local W="\[\033[0;37m\]"    # white

    # emphasized (bolded) colors
    local EMK="\[\033[1;30m\]"
    local EMR="\[\033[1;31m\]"
    local EMG="\[\033[1;32m\]"
    local EMY="\[\033[1;33m\]"
    local EMB="\[\033[1;34m\]"
    local EMM="\[\033[1;35m\]"
    local EMC="\[\033[1;36m\]"
    local EMW="\[\033[1;37m\]"

    # background colors
    local BGK="\[\033[40m\]"
    local BGR="\[\033[41m\]"
    local BGG="\[\033[42m\]"
    local BGY="\[\033[43m\]"
    local BGB="\[\033[44m\]"
    local BGM="\[\033[45m\]"
    local BGC="\[\033[46m\]"
    local BGW="\[\033[47m\]"

    local UC=$W                	# user's color
    [ $UID -eq "0" ] && UC=$R   # root's color

    PS1="$TITLEBAR${EMY}[${EMG}\u@${EMG}\h ${EMB}\\w${EMY}]${UC} \${NONE}"
	#SUDO_PS1="$TITLEBAR ${EMR}[${UC}\u${EMK}@${UC}\h ${EMB}\${NEW_PWD}${EMK}]${UC}\\$ ${NONE}"
	#better prompt
	#PS1='\[\033[1;30m\]\u@\h \W>\$ \[\033[0m\]'
	#better prompt for sudo
	#SUDO_PS1='[\u@\h \W]\$ '
    # without colors: PS1="[\u@\h \${NEW_PWD}]\\$ "
    # extra backslash in front of \$ to make bash colorize the prompt
}

PROMPT_COMMAND=bash_prompt_command
bash_prompt
unset bash_prompt

# export PS1=$(echo "$PS1" | sed 's/\\w/\\w\\[\\033[35m\\]$(parse_git_branch)\\[\\033[0m\\]/g')
export PS1=$(echo "$PS1" | sed 's/\\w/\\w $(parse_git_branch)/g')

# no colors : export PS1=$(echo "$PS1" | sed 's/\\w/\\w$(parse_git_branch)/g')


function manpdf() {
  man -t $@ | open -f -a /Applications/Preview.app/
}

#Experimental REE tuning settings
export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000

export CC=/Users/bcrawford/Developer/bin/gcc-4.2
. "$HOME/.rvm/scripts/rvm"
#rvm use ruby-1.9.2
