# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export EDITOR="code -w"

### zsh
# Path to your oh-my-zsh installation.
export ZSH="/Users/stephanieminn/.oh-my-zsh"
# Set name of the theme to load
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="theunraveler"
# Plugins
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)
source $ZSH/oh-my-zsh.sh

### Aliases
# For a full list of active aliases, run `alias`.
source ~/.aliases

### Functions
# For a full list of active aliases, run `functions`.
source ~/.functions

### rbenv
eval "$(rbenv init -)"

### nvm
NVM_DIR=$HOME/.nvm
. $NVM_DIR/nvm.sh
# nvm use stable

### java SDK
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/stephanieminn/.sdkman"
[[ -s "/Users/stephanieminn/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/stephanieminn/.sdkman/bin/sdkman-init.sh"
