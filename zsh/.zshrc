# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export HOME=/Users/jaredgorski

# Dotfiles repo
export DOTFILES=/Users/jaredgorski/Projects/Personal/dotfiles

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Load zplugin
source '/Users/jaredgorski/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zplugin ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh"
zplugin load trapd00r/LS_COLORS

ZSH_THEME="dollar"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
DEFAULT_USER=``

# Preferred editor for local and remote sessions
export EDITOR='vim'

# ----------------------
# ZSH Vim Stuff
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
# Git Aliases
# ----------------------

alias gcm='git commit --message'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gst='git stash'

# ----------------------
# Other Aliases
# ----------------------

# python3 to python
alias python='python3'
alias pip='pip3'

# clear shortcut
alias cl='clear'

# ----------------------
# Environment Variables
# ----------------------

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
[ -s "/Users/jaredgorski/.scm_breeze/scm_breeze.sh" ] && source "/Users/jaredgorski/.scm_breeze/scm_breeze.sh"

# python3
export PATH="$PATH:$HOME/Library/Python/3.7/bin"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jaredgorski/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jaredgorski/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jaredgorski/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jaredgorski/google-cloud-sdk/completion.zsh.inc'; fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Adding autocomplete for 'lcp'
[ -f ~/.lcp_autocomplete ] && source ~/.lcp_autocomplete

