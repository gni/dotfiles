backup() {
  target=$1
  if [ -e "$target" ]; then           # Does the config file already exist?
    if [ ! -L "$target" ]; then       # as a pure file?
      mv "$target" "$target.backup"   # Then backup it
      echo "Moved your old $target config file to $target.backup"
    fi
  fi
}

#!/bin/zsh
for name in *; do
  if [ ! -d "$name" ]; then
    target="$HOME/.$name"
    if [[ ! "$name" =~ '\.sh$' ]] && [ "$name" != 'README.md' ]; then
      backup $target

      if [ ! -e "$target" ]; then
        echo "Symlinking your new $target"
        ln -s "$PWD/$name" "$target"
      fi
    fi
  fi
done

REGULAR="\\033[0;39m"
YELLOW="\\033[1;33m"
GREEN="\\033[1;32m"

# zsh plugins
CURRENT_DIR=`pwd`
ZSH_PLUGINS_DIR="$HOME/.oh-my-zsh/custom/plugins"
mkdir -p "$ZSH_PLUGINS_DIR" && cd "$ZSH_PLUGINS_DIR"
if [ ! -d "$ZSH_PLUGINS_DIR/zsh-syntax-highlighting" ]; then
  echo "Installing zsh plugin 'zsh-syntax-highlighting'..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting
fi
if [ ! -d "$ZSH_PLUGINS_DIR/zsh-autosuggestions" ]; then
  echo "Installing zsh plugin 'zsh-autosuggestions'..."
  git clone https://github.com/zsh-users/zsh-autosuggestions
fi
cd "$CURRENT_DIR"

# zsh themes
CURRENT_DIR=`pwd`
ZSH_THEMES_DIR="$HOME/.oh-my-zsh/custom/themes"
mkdir -p "$ZSH_THEMES_DIR" && cd "$ZSH_THEMES_DIR"
if [ ! -d "$ZSH_THEMES_DIR/traista" ]; then
  echo "Installing zsh theme 'traistă'..."
  git clone https://github.com/exaluc/traista
fi
cd "$CURRENT_DIR"

zsh ~/.zshrc

source ~/.zshrc

echo "Done!"
