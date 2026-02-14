#!/bin/zsh

# This script creates symlinks from the home directory to the dotfiles in this repository.
# It will show what it plans to do and ask for confirmation before making changes.

set -e

# Variables
DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d%H%M%S)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# Files to symlink: "source:target"
SYMLINKS=(
  "$DOTFILES_DIR/zshrc:$HOME/.zshrc"
  "$DOTFILES_DIR/vim/.vimrc:$HOME/.vimrc"
  "$DOTFILES_DIR/tmux/.tmux.conf:$HOME/.tmux.conf"
  "$DOTFILES_DIR/.editorconfig:$HOME/.editorconfig"
  "$DOTFILES_DIR/.wgetrc:$HOME/.wgetrc"
  "$DOTFILES_DIR/.curlrc:$HOME/.curlrc"
)

# ----------------------------------------------------------------------------
#  Dry-run: show what will happen
# ----------------------------------------------------------------------------
echo "${CYAN}=== Dotfiles Installer ===${NC}"
echo ""
echo "The following changes will be made:"
echo ""

needs_backup=false
for entry in "${SYMLINKS[@]}"; do
  source="${entry%%:*}"
  target="${entry##*:}"
  target_name="${target/$HOME/~}"

  if [ -L "$target" ]; then
    echo "  ${YELLOW}[overwrite symlink]${NC} $target_name"
  elif [ -e "$target" ]; then
    echo "  ${RED}[backup & replace]${NC} $target_name -> will be backed up"
    needs_backup=true
  else
    echo "  ${GREEN}[create]${NC} $target_name"
  fi
done

# Git config is handled separately (include, not replace)
if git config --global --get include.path 2>/dev/null | grep -q ".gitconfig-shared"; then
  echo "  ${YELLOW}[already included]${NC} ~/.gitconfig (include path)"
else
  echo "  ${GREEN}[append include]${NC}  ~/.gitconfig (will NOT replace, adds include only)"
fi

if [ "$needs_backup" = true ]; then
  echo ""
  echo "Existing files will be backed up to: ${CYAN}${BACKUP_DIR/$HOME/~}${NC}"
fi

echo ""
printf "Proceed? [y/N] "
read -r reply
if [[ ! "$reply" =~ ^[Yy]$ ]]; then
  echo "Aborted."
  exit 0
fi

echo ""

# ----------------------------------------------------------------------------
#  Symlink helper
# ----------------------------------------------------------------------------
create_symlink() {
  local source=$1
  local target=$2

  if [ -L "$target" ] || [ -e "$target" ]; then
    if [ -L "$target" ]; then
      rm "$target"
      echo "  Removed old symlink: $target"
    else
      if [ ! -d "$BACKUP_DIR" ]; then
        mkdir -p "$BACKUP_DIR"
        echo "  Created backup directory: $BACKUP_DIR"
      fi
      mv "$target" "$BACKUP_DIR/"
      echo "  Backed up: $target"
    fi
  fi

  ln -s "$source" "$target"
  echo "  ${GREEN}Linked${NC}: $target -> $source"
}

# ----------------------------------------------------------------------------
#  Oh-My-Zsh
# ----------------------------------------------------------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "${CYAN}Installing Oh-My-Zsh...${NC}"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# ----------------------------------------------------------------------------
#  Symlinks
# ----------------------------------------------------------------------------
echo "${CYAN}Creating symlinks...${NC}"
for entry in "${SYMLINKS[@]}"; do
  source="${entry%%:*}"
  target="${entry##*:}"
  create_symlink "$source" "$target"
done

# ----------------------------------------------------------------------------
#  Git config (include, never replace)
# ----------------------------------------------------------------------------
echo "${CYAN}Configuring git...${NC}"
GITCONFIG_SHARED="$DOTFILES_DIR/git/.gitconfig-shared"

if git config --global --get-all include.path 2>/dev/null | grep -q ".gitconfig-shared"; then
  echo "  ${YELLOW}Already included${NC}: .gitconfig-shared"
else
  git config --global --add include.path "$GITCONFIG_SHARED"
  echo "  ${GREEN}Added include${NC}: $GITCONFIG_SHARED"
fi

# Check if user identity is set
if [ -z "$(git config --global user.name 2>/dev/null)" ]; then
  echo ""
  echo "  ${YELLOW}Warning${NC}: git user.name is not set."
  echo "  Run: git config --global user.name \"Your Name\""
fi
if [ -z "$(git config --global user.email 2>/dev/null)" ]; then
  echo "  ${YELLOW}Warning${NC}: git user.email is not set."
  echo "  Run: git config --global user.email \"your@email.com\""
fi

# ----------------------------------------------------------------------------
#  Vim
# ----------------------------------------------------------------------------
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
  echo "${CYAN}Installing vim-plug...${NC}"
  curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "${CYAN}Installing vim plugins...${NC}"
vim +PlugInstall +qall

# ----------------------------------------------------------------------------
#  Zsh plugins
# ----------------------------------------------------------------------------
echo "${CYAN}Installing zsh plugins...${NC}"
ZSH_PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins"
mkdir -p "$ZSH_PLUGINS_DIR"

install_zsh_plugin() {
  local name=$1
  local repo=$2
  if [ ! -d "$ZSH_PLUGINS_DIR/$name" ]; then
    echo "  Installing $name..."
    git clone "$repo" "$ZSH_PLUGINS_DIR/$name"
  else
    echo "  ${YELLOW}Already installed${NC}: $name"
  fi
}

install_zsh_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting"
install_zsh_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"
install_zsh_plugin "history-substring-search" "https://github.com/zsh-users/zsh-history-substring-search"

# ----------------------------------------------------------------------------
#  Zsh themes
# ----------------------------------------------------------------------------
echo "${CYAN}Installing zsh themes...${NC}"
ZSH_THEMES_DIR="$HOME/.oh-my-zsh/custom/themes"
mkdir -p "$ZSH_THEMES_DIR"
if [ ! -d "$ZSH_THEMES_DIR/traista" ]; then
  echo "  Installing traistă..."
  git clone https://github.com/gni/traista "$ZSH_THEMES_DIR/traista"
else
  echo "  ${YELLOW}Already installed${NC}: traista"
fi

# ----------------------------------------------------------------------------
#  Compile zsh files (faster loading)
# ----------------------------------------------------------------------------
echo "${CYAN}Compiling zsh files...${NC}"
for f in "$DOTFILES_DIR"/zsh/*.zsh "$DOTFILES_DIR"/zshrc; do
  zcompile "$f" 2>/dev/null && echo "  Compiled: $(basename $f)"
done

# ----------------------------------------------------------------------------
#  Done
# ----------------------------------------------------------------------------
echo ""
echo "${GREEN}Installation complete!${NC} Please restart your shell."
