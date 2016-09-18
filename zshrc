# Path to your oh-my-zsh installation.
export ZSH=/Users/deweymcneill/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="pure"

plugins=(git npm brew chucknorris compleat jira jsontools lol nyan web-search wd expand-aliases)

export PATH="/Users/deweymcneill/.nvm/v0.10.40/bin:/usr/local/heroku/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/Users/deweymcneill/bin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

. ~/.nvm/nvm.sh

. ~/.z.sh

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

function mkalias () 
{ 
  alias "$*";
  echo alias "$*" >> ~/.bash_aliases
}

myip() {ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'}

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

ulimit -n 10000
