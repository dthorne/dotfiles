# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export ZSHRC=~/.zshrc
# export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*}"'
export FZF_DEFAULT_COMMAND='ag --hidden -g ""'

export CHOKIDAR_USEPOLLING=true
export ANDROID_HOME=~/Android/Sdk/
export ANDROID_SDK_ROOT=~/Android/Sdk/
export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH"

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

export XDG_CONFIG_HOME=~/dotfiles

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
export NVM_LAZY_LOAD=true

export PATH="$HOME/src/flutter/bin:$PATH"

export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
#export DISPLAY=localhost:0
export LIBGL_ALWAYS_INDIRECT=1

#antigen setup
source $HOME/.oh-my-zsh/plugins/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle npm
antigen bundle nvm
antigen bundle compleat
antigen bundle jira
antigen bundle jsontools
antigen bundle web-search
antigen bundle wd
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search ./zsh-history-substring-search.zsh

antigen bundle lukechilds/zsh-nvm
antigen bundle Sparragus/zsh-auto-nvm-use

antigen theme https://github.com/denysdovhan/spaceship-prompt spaceship

antigen apply

# custom fzf integrated actions
function fn_cherry_pick() {
  commit=$(git log --pretty=format:"%h %s" --branches='*' -n 100 \
    | fzf --height "90%" --header "PLEASE CHOOSE A COMMIT TO CHERRY-PICK" --reverse --border --ansi --preview "git show --color=always {1}" \
    | awk '{print $1}')
  if [ -n "$commit" ]; then
    git cherry-pick $commit
  fi
}
alias gcp=fn_cherry_pick

function fn_git_checkout() {
    branch=$(git branch --all | fzf | sed "s/remotes\/origin\///" | xargs)
    git checkout $branch
}
alias gco='fn_git_checkout'

eval 
TWILIO_AC_ZSH_SETUP_PATH=/home/dewey/.twilio-cli/autocomplete/zsh_setup && test -f $TWILIO_AC_ZSH_SETUP_PATH && source $TWILIO_AC_ZSH_SETUP_PATH; # twilio autocomplete setup
