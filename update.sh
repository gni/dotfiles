#!/bin/zsh

# Pull the latest dotfiles and update all plugins.

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Updating dotfiles..."
git -C "$DOTFILES_DIR" pull --rebase

echo "Updating vim plugins..."
vim +PlugUpdate +qall

echo "Updating zsh plugins..."
ZSH_PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins"
for plugin_dir in "$ZSH_PLUGINS_DIR"/*/; do
  if [ -d "$plugin_dir/.git" ]; then
    plugin_name=$(basename "$plugin_dir")
    echo "  Updating $plugin_name..."
    git -C "$plugin_dir" pull --rebase
  fi
done

echo "Updating zsh themes..."
ZSH_THEMES_DIR="$HOME/.oh-my-zsh/custom/themes"
for theme_dir in "$ZSH_THEMES_DIR"/*/; do
  if [ -d "$theme_dir/.git" ]; then
    theme_name=$(basename "$theme_dir")
    echo "  Updating $theme_name..."
    git -C "$theme_dir" pull --rebase
  fi
done

echo "Recompiling zsh files..."
for f in "$DOTFILES_DIR"/zsh/*.zsh "$DOTFILES_DIR"/zshrc; do
  zcompile "$f" 2>/dev/null
done

echo "Update complete! Restart your shell to apply changes."
