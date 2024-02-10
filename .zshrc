# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT=$'%F{green}%~%f %F{black}%D{%d/%m/%y} %* ${vcs_info_msg_0_}%f\n$ '
update_rprompt() {
    if [ -n "${AWS_PROFILE}" ]; then
        RPROMPT='%F{yellow}aws: $AWS_PROFILE%f'
    else
        RPROMPT=''
    fi
}
precmd_functions+=(update_rprompt)

## Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats 'on %b'

export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacax

# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# タイプ補完
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# zsh-completions
if [ -e /usr/local/share/zsh-completions ]; then
    fpath=(/usr/local/share/zsh-completions $fpath)
fi
autoload -U compinit
compinit -u

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

autoload colors
colors

# case-insensitive completion
#zstyle ':completion:*' list-colors ''
#zstyle ':completion:*:default' list-colors ${(s.:.)LSCOLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=2

# history
HISTFILE=/Users/paraizo2424/.zsh_hist
HISTSIZE=1000
SAVEHIST=1000
setopt extended_history # Save execution time as well
setopt share_history # share history between prompts
setopt hist_ignore_all_dups # ignore all duplicates

# peco
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# aliases
alias his='history | grep'
alias ls='ls -G'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias class='cd ~/Desktop/University/Classes/20sem2'
alias dcud='docker-compose up -d'
alias dcd='docker-compose down'
alias dcps='docker-compose ps'
alias awsp="source _awsp"

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

export DENO_INSTALL="/Users/yukoga/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export DVM_DIR="/Users/yukoga/.dvm"
export PATH="$DVM_DIR/bin:$PATH"

eval "$(direnv hook zsh)"
export EDITOR=vi

eval "$(rbenv init - zsh)"

# openssl
export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@1.1/lib/pkgconfig"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/opt/homebrew/opt/openssl@1.1"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/yukoga/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/yukoga/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/yukoga/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/yukoga/google-cloud-sdk/completion.zsh.inc'; fi

# switch node versions automatically
function load-node-version {
  if [ -f ".node-version" ]; then
    local version=$(cat .node-version)
    nodebrew use $version
    echo "Switched to Node.js $version"
  fi
}
autoload -U add-zsh-hook
add-zsh-hook chpwd load-node-version

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
