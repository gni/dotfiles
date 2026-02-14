# Resolve the dotfiles directory by following the ~/.zshrc symlink
DOTFILES_DIR="${${:-$HOME/.zshrc}:A:h}"

# Set Zsh home
ZSH=$HOME/.oh-my-zsh

# Disable oh-my-zsh auto-update prompt (saves a check on every startup)
DISABLE_AUTO_UPDATE="true"

# Disable magic functions (speeds up pasting in terminal)
DISABLE_MAGIC_FUNCTIONS="true"

# Load the theme
ZSH_THEME="traista/traista"

# Load plugins list
source "$DOTFILES_DIR/zsh/plugins.zsh"

# Actually load Oh-My-Zsh (must come before custom config so our aliases take priority)
source "${ZSH}/oh-my-zsh.sh"

# Load exports
source "$DOTFILES_DIR/zsh/exports.zsh"

# Load custom configuration
source "$DOTFILES_DIR/zsh/config.zsh"

# Load custom functions
source "$DOTFILES_DIR/zsh/functions.zsh"

# Load aliases (last, so they override everything)
source "$DOTFILES_DIR/zsh/aliases.zsh"
