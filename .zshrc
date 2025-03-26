# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='cursor'
fi

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

USER=`whoami`

# Useful functions
function manpdf() {
  man -t $@ | open -f -a /Applications/Preview.app/
}

q() {
  local url="$1"
  local question="$2"

  # Fetch the URL content through Jina
  local content=$(curl -s "https://r.jina.ai/$url")

  # Check if the content was retrieved successfully
  if [ -z "$content" ]; then
    echo "Failed to retrieve content from the URL."
    return 1
  fi

  system="
  You are a helpful assistant that can answer questions about the content.
  Reply concisely, in a few sentences.

  The content:
  ${content}
  "

  # Use llm with the fetched content as a system prompt
  llm prompt "$question" -s "$system"
}

qv() {
  local url="$1"
  local question="$2"

  # Fetch the URL content through Jina
  local subtitle_url=$(yt-dlp -q --skip-download --convert-subs srt --write-sub --sub-langs "en" --write-auto-sub --print "requested_subtitles.en.url" "$url")
  local content=$(curl -s "$subtitle_url" | sed '/^$/d' | grep -v '^[0-9]*$' | grep -v '\-->' | sed 's/<[^>]*>//g' | tr '\n' ' ')

  # Check if the content was retrieved successfully
  if [ -z "$content" ]; then
    echo "Failed to retrieve content from the URL."
    return 1
  fi

  system="
  You are a helpful assistant that can answer questions about YouTube videos.
  Reply concisely, in a few sentences.

  The content:
  ${content}
  "

  # Use llm with the fetched content as a system prompt
  llm prompt "$question" -s "$system"
}

yts() {
  local url="$1"
  local output_file="${2:-transcript.md}"

  # Fetch subtitles from YouTube
  local subtitle_url=$(yt-dlp -q --skip-download --convert-subs srt --write-sub --sub-langs "en" --write-auto-sub --print "requested_subtitles.en.url" "$url")
  curl -o /tmp/subtitles.vtt -s "$subtitle_url"

  # Check if the content was retrieved successfully
  if [ ! -f "/tmp/subtitles.vtt" ]; then
    echo "Failed to retrieve subtitles from the URL."
    return 1
  fi

  # Convert VTT to Markdown
  vtt2md < /tmp/subtitles.vtt > "$output_file"

  # Check if the output file was created successfully
  if [ ! -f "$output_file" ]; then
    echo "Failed to create output file: $output_file"
    rm -f /tmp/subtitles.vtt
    return 1
  fi

  # Clean up temporary file
  rm -f /tmp/subtitles.vtt
  echo "Transcript saved to: $output_file"
}

# Function to set SAND_API_KEY from keys file
set_sand_key() {
    if [[ -z "$1" ]]; then
        echo "Usage: set_sand_key <key_name>"
        echo "Sets the SAND_API_KEY environment variable from a key stored in ~/.sandgarden/keys"
        echo "Example: set_sand_key production"
        return 1
    fi
    
    local key_name=$1
    local keys_file="$HOME/.sandgarden/keys"
    
    if [[ ! -f "$keys_file" ]]; then
        echo "Keys file not found at $keys_file"
        return 1
    fi
    
    local key_value=$(awk -F'=' "/^\[$key_name\]/{getline; print \$1}" "$keys_file")
    
    if [[ -z "$key_value" ]]; then
        echo "Key '$key_name' not found"
        return 1
    fi
    
    export SAND_API_KEY="$key_value"
    echo "SAND_API_KEY set for $key_name"
}

# Function to list available keys
list_sand_keys() {
    if [[ -n "$1" ]]; then
        echo "Usage: list_sand_keys"
        echo "Lists all available key names from ~/.sandgarden/keys"
        return 1
    fi
    
    local keys_file="$HOME/.sandgarden/keys"
    
    if [[ ! -f "$keys_file" ]]; then
        echo "Keys file not found at $keys_file"
        return 1
    fi
    
    grep '^\[.*\]' "$keys_file" | tr -d '[]'
}

# Function to print a specific key
get_sand_key() {
    if [[ -z "$1" ]]; then
        echo "Usage: get_sand_key <key_name>"
        echo "Prints the value of a specific key from ~/.sandgarden/keys"
        echo "Example: get_sand_key production"
        return 1
    fi
    
    local key_name=$1
    local keys_file="$HOME/.sandgarden/keys"
    
    if [[ ! -f "$keys_file" ]]; then
        echo "Keys file not found at $keys_file"
        return 1
    fi
    
    local key_value=$(awk -F'=' "/^\[$key_name\]/{getline; print \$1}" "$keys_file")
    
    if [[ -z "$key_value" ]]; then
        echo "Key '$key_name' not found"
        return 1
    fi
    
    echo "$key_value"
}


# Aliases
alias zshconfig="$EDITOR ~/.zshrc && . ~/.zshrc"
alias ohmyzsh="$EDITOR ~/.oh-my-zsh"
alias zshrefresh=". ~/.zshrc"
alias topcpu='ps aux | sort -n +2 | tail -10'  # top 10 cpu processes
alias topmem='ps aux | sort -n +3 | tail -10'  # top 10 memory processes
alias duf='du -sk * | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'
alias aid='source ~/.aider/bin/activate && aider --env-file ~/.aider/.env'
alias o="open"

# Typos
alias gti="git"

# pnpm
export PNPM_HOME="/Users/brittcrawford/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH="$PATH:/Users/$USER/go/bin/:$HOME/.local/bin"
export ICLOUD_PATH="/Users/$USER/Library/Mobile Documents/com~apple~CloudDocs"

export PATH=$PATH:$HOME/.local/bin
. $HOME/.local/bin/env
