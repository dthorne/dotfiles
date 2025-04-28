# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export ZSHRC=~/.zshrc
export FZF_DEFAULT_COMMAND='ag --hidden -g ""'

export CHOKIDAR_USEPOLLING=true
export ANDROID_HOME=~/Android/Sdk/
export ANDROID_SDK_ROOT=~/Android/Sdk/
export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/bin/nvim-11/bin:$PATH"

export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64

export XDG_CONFIG_HOME=~/dotfiles

export PATH="$HOME/src/flutter/bin:$PATH"

export DISPLAY=$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):0.0
export LIBGL_ALWAYS_INDIRECT=1

export VISUAL=nvim
export EDITOR="$VISUAL"

#antigen setup
source $HOME/.oh-my-zsh/plugins/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle npm
# antigen bundle nvm
antigen bundle kubectl
antigen bundle compleat
antigen bundle jira
antigen bundle jsontools
antigen bundle web-search
antigen bundle wd
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search ./zsh-history-substring-search.zsh

antigen bundle kubectl

# antigen bundle lukechilds/zsh-nvm
# antigen bundle Sparragus/zsh-auto-nvm-use

antigen theme https://github.com/denysdovhan/spaceship-prompt spaceship

antigen apply

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

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
    branch=$(git branch --all --sort=-committerdate | fzf | sed "s/remotes\/origin\///" | xargs)
    git checkout $branch
}
alias gco='fn_git_checkout'

# pnpm
export PNPM_HOME="/home/dewey/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
# 

# custom commands
alias gg="lazygit"
alias ducks='du -cksh * | sort -hr | head -n 15'
alias code="code-insiders"
alias nvim11="~/bin/nvim-11/bin/nvim"

#docker
alias dockerstop="docker stop $(docker ps -a -q)"
alias dockerkill="docker rm $(docker ps -a -q)"
alias dockerstopkill="docker ps -aq | xargs docker rm -f"

# k8s
alias k="kubectl"
alias kdev="kubectl --namespace dev"
alias kprod="kubectl --namespace prod"
alias kmon="kubectl --namespace monitoring"
alias koutset="kubectl config use-context outset-aks"
alias kb2b="kubectl config use-context aks-us-central"
alias hdev="helm --namespace dev"
alias hprod="Helm --namespace prod"
alias kdevsecrets="kdev get secret keyvault-secrets -o json"
alias kprodsecrets="kprod get secret keyvault-secrets -o json"
alias kdevshared="kdev describe configmap shared-config"
alias kprodshared="kprod describe configmap shared-config"
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

n ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn -e "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f -- "$NNN_TMPFILE" > /dev/null
    }
}



# Load Angular CLI autocompletion.
source <(ng completion script)

# fnm
FNM_PATH="/Users/dmcneill/Library/Application Support/fnm"
export PATH="/Users/dmcneill/Library/Application Support/fnm:$PATH"
alias nvm=fnm
eval "`fnm env --use-on-cd --shell zsh`"
