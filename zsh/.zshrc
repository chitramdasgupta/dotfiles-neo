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

alias nvim='~/nvim.appimage'

eval "$(starship init zsh)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# This should be at the end
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
