# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(git node npm brew z screen sudo)
source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR='code'
fi

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Aliases
alias zshconfig="$EDITOR ~/.zshrc && . ~/.zshrc"
alias zshrefresh=". ~/.zshrc"
alias topcpu='ps aux | sort -n +2 | tail -10'  # top 10 cpu processes
alias topmem='ps aux | sort -n +3 | tail -10'  # top 10 memory processes
alias duf='du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'
alias aid='source ~/.aider/bin/activate && aider --env-file ~/.aider/.env'
alias o="open"
alias setopenai="export OPENAI_API_KEY=`op item get sbwbstgfv55iepn373hsfu2zja --reveal --format json | jq -r '.fields[] | select(.id == \"credential\") | .value'`"

# Typos
alias gti="git"


# Useful functions
function manpdf() {
  man -t $@ | open -f -a /Applications/Preview.app/
}

# pnpm
export PNPM_HOME="/Users/brittcrawford/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$HOME/bin:$HOME/go/bin

export PATH=$PATH:$HOME/.local/bin
source $HOME/.local/bin/env