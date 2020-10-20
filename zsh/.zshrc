# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Some Homebrew executables live here
export PATH=/usr/local/sbin:$PATH

# Dotfiles repo
export DOTFILES=$HOME/Projects/Personal/dotfiles

# ----------------------
# oh-my-zsh setup
# ----------------------

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# oh-my-zsh prompt theme
ZSH_THEME="jaredgorski"

# oh-my-zsh plugins
plugins=(git)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# User configuration
DEFAULT_USER=``

# Preferred editor for local and remote sessions
export EDITOR='vim'

# ----------------------
# ZSH Vim bindings
# ----------------------

# Set vi mode
bindkey -v

# Better searching in command mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# Beginning search with arrow keys
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# `v` is already mapped to visual mode, so we need to use a different key to
# open Vim
bindkey -M vicmd "^V" edit-command-line

# Speed up transition between vim modes
export KEYTIMEOUT=1

# ----------------------
# Functions
# ----------------------
zet () {
  vim -c "Zet $1"
}

alias zetbl='~/vimwiki-utilities/backlinks.pl'

function httpless {
  # `httpless example.org'
  http --pretty=all --print=hb "$@" | less -R;
}

# ----------------------
# Git aliases
# ----------------------

alias gcm='git commit --message'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gst='git stash'

# ----------------------
# Other Aliases
# ----------------------

# kubectl ctx to kubectx
alias kubectx='kubectl ctx'

# use vim always
alias vi='vim'

# ----------------------
# Extra
# ----------------------

# Enable C-v (in Normal command line mode) to edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd C-v edit-command-line

# ----------------------
# Environment variables
# (and installations)
# ----------------------

# FZF
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Golang
export GOPATH=$HOME/projects/Go_Workspace
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export PATH=${PATH}:${GOPATH//://bin:}/bin

# Rust
export PATH=$PATH:$HOME/.cargo/bin

# Perl
source $HOME/perl5/perlbrew/etc/bashrc

# JDK installation
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_201.jdk/Contents/Home

# scm breeze
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"

# Python
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

alias python=python3
alias pip=pip3


# Google Cloud SDK
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jaredgorski/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jaredgorski/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/jaredgorski/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jaredgorski/google-cloud-sdk/completion.zsh.inc'; fi

# krew (kubectl plugin manager)
export PATH="${PATH}:${HOME}/.krew/bin"

# Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
