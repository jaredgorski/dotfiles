
# Adding autocomplete for 'we'
[ -f ~/.lcp_autocomplete ] && source ~/.lcp_autocomplete

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# RVM
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM 

