export NVM_DIR="$HOME/.nvm"

# This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  

# Case-insensitive autocomplete
autoload -Uz compinit && compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# History
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.histfile

# Ignore duplicates in history
setopt HIST_IGNORE_ALL_DUPS

# Fuzzy find your way through life!
cdf() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# Fuzzy history search function
hf() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

export PATH="/usr/sbin:$PATH"

alias nvim='~/nvim.appimage'
alias cat='batcat -p'
alias ls="eza --icons='always'"

eval "$(starship init zsh)"

eval "$(zoxide init zsh)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# JAVA_HOME
export JAVA_HOME="/home/cdg/.jdks/jdk-21.0.2/"

# Add Java bin directory to PATH
export PATH="$PATH:/home/cdg/.jdks/jdk-21.0.2/bin/"

# Auto-complete
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(rbenv init -)"

eval "$(~/.local/bin/mise activate zsh)"

# This should be at the end
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
