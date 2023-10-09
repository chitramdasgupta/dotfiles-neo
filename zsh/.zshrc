# Basic autocomplete
autoload -Uz compinit promptinit
compinit
promptinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# History
HISTSIZE=2000
SAVEHIST=2000
HISTFILE=~/.histfile

alias ls='ls --color=yes --human-readable'
alias code='code --password-store=basic'

export EDITOR=vim

source /usr/share/nvm/init-nvm.sh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
source ~/.rvm/scripts/rvm

# Starship as the init prompt
eval "$(starship init zsh)"

# Auto suggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#00bdbd,underline"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# This has to be the last source
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
