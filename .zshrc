# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT=$'%F{green}%~%f %F{black}${vcs_info_msg_0_}%f\n$ '
RPROMPT='%F{yellow}$AWS_PROFILE%f'

## Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%b'

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
