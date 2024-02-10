# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zprofile.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zprofile.pre.zsh"
# export PATH=$PATH:/Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home/bin
export JAVA_HOME=`/usr/libexec/java_home -v 11`

export PATH=$PATH:~/bin

export PATH=$HOME/anaconda3/bin:$PATH

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH=$PATH:/Users/yukoga/.nodebrew/current/bin

export PATH="$PATH:$HOME/Library/flutter/bin"
export PATH="$PATH:$HOME/Library/flutter/bin/cache/dart-sdk/bin"

export DOTNET_ROOT='/usr/local/share/dotnet'
export PATH="$PATH:/usr/local/share/dotnet"

# Added by Toolbox App
export PATH="$PATH:/usr/local/bin"

eval "$(/opt/homebrew/bin/brew shellenv)"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zprofile.post.zsh" ]] && builtin source "$HOME/.fig/shell/zprofile.post.zsh"
