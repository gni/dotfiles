# Default editor
export EDITOR="vim"
export VISUAL="vim"

# Pager
export PAGER="less"
export LESS="-R"

# Encoding
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Cache OS name (avoids repeated subshells)
export DOTFILES_OS="$(uname)"

# Base PATH
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# ----------------------------------------------------------------------------
#  Lazy loaders — tools that use eval "$(tool init)" are slow (~100-400ms each)
#  Stub functions defer loading until first actual use
# ----------------------------------------------------------------------------

# rbenv (lazy)
if [ -d "$HOME/.rbenv" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  _rbenv_lazy_load() {
    unset -f rbenv ruby gem bundle rake 2>/dev/null
    eval "$(rbenv init - zsh)"
  }
  rbenv()  { _rbenv_lazy_load; rbenv "$@"; }
  ruby()   { _rbenv_lazy_load; ruby "$@"; }
  gem()    { _rbenv_lazy_load; gem "$@"; }
  bundle() { _rbenv_lazy_load; bundle "$@"; }
  rake()   { _rbenv_lazy_load; rake "$@"; }
fi

# nvm (lazy — nvm is the slowest, ~400ms)
if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  # Add default node to PATH so tools like vim/coc.nvim can find it
  local nvm_default="$NVM_DIR/alias/default"
  if [ -f "$nvm_default" ]; then
    local nvm_version
    nvm_version="$(cat "$nvm_default")"
    local nvm_node_dir="$NVM_DIR/versions/node"
    # Resolve partial version (e.g. "20") to full path
    local nvm_node_path="$(ls -d "$nvm_node_dir"/v${nvm_version}* 2>/dev/null | tail -1)"
    [ -n "$nvm_node_path" ] && export PATH="$nvm_node_path/bin:$PATH"
  fi
  _nvm_lazy_load() {
    unset -f nvm 2>/dev/null
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
  }
  nvm() { _nvm_lazy_load; nvm "$@"; }
fi

# fnm (lazy)
if [ -d "$HOME/.fnm" ] || whence -p fnm &>/dev/null; then
  _fnm_lazy_load() {
    unset -f fnm 2>/dev/null
    eval "$(fnm env --use-on-cd)"
  }
  fnm() { _fnm_lazy_load; fnm "$@"; }
  # If fnm is present but nvm stubs aren't set, stub node/npm too
  if ! [ -d "$HOME/.nvm" ]; then
    node() { _fnm_lazy_load; node "$@"; }
    npm()  { _fnm_lazy_load; npm "$@"; }
    npx()  { _fnm_lazy_load; npx "$@"; }
  fi
fi

# Go (just PATH, no eval — already fast)
if [ -d "/usr/local/go" ]; then
  export GOPATH="$HOME/go"
  export PATH="/usr/local/go/bin:$GOPATH/bin:$PATH"
fi

# Rust / Cargo (just sources a file — already fast)
if [ -f "$HOME/.cargo/env" ]; then
  source "$HOME/.cargo/env"
fi

# pyenv (lazy)
if [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  _pyenv_lazy_load() {
    unset -f pyenv python python3 pip pip3 2>/dev/null
    eval "$(pyenv init - zsh)"
  }
  pyenv()   { _pyenv_lazy_load; pyenv "$@"; }
  python()  { _pyenv_lazy_load; python "$@"; }
  python3() { _pyenv_lazy_load; python3 "$@"; }
  pip()     { _pyenv_lazy_load; pip "$@"; }
  pip3()    { _pyenv_lazy_load; pip3 "$@"; }
fi
