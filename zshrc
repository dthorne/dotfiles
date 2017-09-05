# Path to your oh-my-zsh installation.
export ZSH=/Users/deweymcneill/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#autoload -U promptinit; promptinit
#prompt pure
ZSH_THEME="pure"

plugins=(git npm brew chucknorris compleat jira jsontools lol nyan web-search wd expand-aliases)

export PATH="/Users/deweymcneill/.nvm/v0.10.40/bin:/usr/local/heroku/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/Users/deweymcneill/bin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

if [ -f $HOME/dotfiles/bash_aliases ]; then
    . $HOME/dotfiles/bash_aliases
fi

. ~/.nvm/nvm.sh

. ~/.z.sh

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
export SAUCE_USERNAME=dmcneill
export SAUCE_ACCESS_KEY=2f3b6e44-4049-45e3-8820-8a8a58f41bac

function mkalias () 
{ 
  alias "$*";
  echo alias "$*" >> $HOME/dotfiles/bash_aliases
}

myip() {ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'}

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ulimit -n 10000
