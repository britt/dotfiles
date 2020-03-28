# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="muse"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git node npm brew z git_remote_branch osx screen sudo)
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR='vscode'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases

alias gps='cd $GPS'
alias zshconfig="$EDITOR ~/.zshrc && . ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"
alias o="open"
alias topcpu='ps aux | sort -n +2 | tail -10'  # top 10 cpu processes
alias topmem='ps aux | sort -n +3 | tail -10'  # top 10 memory processes
alias duf='du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'
alias be="bundle exec $1"
alias gti="git"
alias gs="rvm gemset use $1"
alias gh_deploy="git checkout master && git merge dev && git push && git checkout dev"
alias repath="source ~/.zshrc"
alias tf="terraform"
alias gopathme='origDir="$PWD"; lastDir=""; while [ "$lastDir" != "$PWD" ]; do if [ -d src ]; then export GOPATH="$PWD"; export PATH="$GOPATH/bin:$PATH"; break; fi; lastDir="$PWD"; cd ../; done; cd $origDir;'

function manpdf() {
  man -t $@ | open -f -a /Applications/Preview.app/
}

# StrongDM code sync
PROJECTS=("web" "mysql" "mssql" "mongo" "dbtest" "dbplugin" "postgres" "tf" "redis" "presto" "dynamodb" "elastic" "bigquery" "memcached" "cassandra")
function pullall() {
  for i in $PROJECTS
  do
    cd $GPS && cd $i && git pull
  done
  cd $GPS
}

function pushall() {
  for i in $PROJECTS
  do
    cd $GPS && cd $i && git push
  done
  cd $GPS
}


# Link gpg-agent and pinentry
if test -f ~/.gnupg/.gpg-agent-info -a -n "$(pgrep gpg-agent)"; then
  source ~/.gnupg/.gpg-agent-info
  export GPG_AGENT_INFO
  GPG_TTY=$(tty)
  export GPG_TTY
else
  eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
fi


# source ~/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
### Added by the Heroku Toolbelt
export GOPATH="$HOME/workspace/go"
export GPS="$GOPATH/src/github.com/strongdm"
export GOBRITT="$GOPATH/src/github.com/britt"

# source ~/workspace/go/src/github.com/strongdm/web/.sdmenv

# source /Volumes/Keybase/private/britt,jmccarthy/signing/signing.env
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export SDM_DOCKERIZED=true
export SDM_VERBOSE=true
export ENABLE_FLUTTER_DESKTOP=true

alias ssh="/Users/britt/bin/sdm ssh wrapped-run"
alias scp="scp -S'/Users/britt/bin/sdm' -osdmSCP"
alias devkey="cat /Volumes/Keybase/private/britt,jmccarthy/ssh-privkeys/dev/sdm-dev.passphrase | pbcopy && ssh-add /Volumes/Keybase/private/britt,jmccarthy/ssh-privkeys/dev/sdm-dev"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
export GO111MODULE=on
export PATH="$PATH:$HOME/.yarn/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:~/.rvm/bin:/Users/britt/.rvm/bin:/usr/local/go/bin:$GOPATH/bin/:$HOME/bin:$HOME/.rvm/bin:$HOME/bin/flutter/bin:$HOME/.cargo/bin"
