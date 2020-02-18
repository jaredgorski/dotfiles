# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export HOME=/Users/jaredgorski

# Dotfiles repo
export DOTFILES=/Users/jaredgorski/Projects/Personal/dotfiles

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

zplugin ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh"
zplugin load trapd00r/LS_COLORS

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="dollar"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
DEFAULT_USER=``

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

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
alias gcob="git checkout -b"
alias ga='git add'
alias gaa='git add -A'
alias gd='git diff'
alias gr='git reset'
alias gst='git stash'
alias gsta='git stash apply'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash save'

# ----------------------
# LCP Infra Aliases
# ----------------------

alias drmc='drmc () {
    docker service rm $(docker service ls -q)
    docker rm -f $(docker ps -q -a)
    docker system prune -f
}'
alias drmall='drmall () {
    docker service rm $(docker service ls -q)
    docker rm -f $(docker ps -q -a)
    docker system prune -f
    docker rmi -f $(docker images -q)
    docker network rm $(docker network ls -q -f name=com.wedeploy)
    docker volume rm $(docker volume ls -qf dangling=true)
}'
alias createapi='telepresence --local-cluster --swap-deployment api --expose 3002 --logfile /dev/null --run npm run dev'
alias createcon='telepresence --local-cluster --swap-deployment console --expose 3005 --logfile /dev/null --run npm run dev'

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

### Added by Zplugin's installer
source '/Users/jaredgorski/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

# Adding autocomplete for 'lcp'
[ -f ~/.lcp_autocomplete ] && source ~/.lcp_autocomplete

