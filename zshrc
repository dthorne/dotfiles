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

source $ZSH/oh-my-zsh.sh

# export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*}"'
export FZF_DEFAULT_COMMAND='ag -g ""'

export CHOKIDAR_USEPOLLING=true

#export $(dbus-launch)
#export LIBGL_ALWAYS_INDIRECT=1

#export WSL_HOST=$(tail -1 /etc/resolv.conf | cut -d' ' -f2)
#export DISPLAY=$WSL_HOST:0

#export ADB_SERVER_SOCKET=tcp:$WSL_HOST:5037


#export ANDROID_HOME=/mnt/c/Users/dewey/AppData/Local/Android/Sdk
#export ANDROID_SDK_ROOT=/mnt/c/Users/dewey/AppData/Local/Android/Sdk
export ANDROID_HOME=~/Android/Sdk/
export ANDROID_SDK_ROOT=~/Android/Sdk/
export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH"

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64


#alias emulator=/mnt/c/Users/dewey/AppData/Local/Android/Sdk/emulator/emulator.exe
#alias adb=/mnt/c/Users/dewey/AppData/Local/Android/Sdk/platform-tools/adb.exe
