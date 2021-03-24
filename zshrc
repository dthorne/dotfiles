# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
fpath+=$HOME/.zsh/pure
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
autoload -U promptinit; promptinit
prompt pure

plugins=(git npm compleat jira jsontools web-search wd)
fpath+=('/home/dthorne/.nvm/versions/node/v9.11.2/lib/node_modules/pure-prompt/functions')
fpath+=('$PWD/functions')

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="/Users/deweymcneill/.nvm/v0.10.40/bin:/usr/local/heroku/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export PATH="/Users/deweymcneill/bin:$PATH"

source $ZSH/oh-my-zsh.sh

# export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*}"'
export FZF_DEFAULT_COMMAND='ag -g ""'

export CHOKIDAR_USEPOLLING=true
