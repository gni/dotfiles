ZSH=$HOME/.oh-my-zsh

ZSH_THEME="traista/traista"

# Useful plugins
plugins=(gitfast last-working-dir rbenv common-aliases zsh-syntax-highlighting history-substring-search)

# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"

# Store aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Store exports in the ~/.exports file and load the here.
[[ -f "$HOME/.exports" ]] && source "$HOME/.exports"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

