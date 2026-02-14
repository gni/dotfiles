# Create a directory and change into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# ----------------------------------------------------------------------------
#  Automatic Python Virtualenv Activation
# ----------------------------------------------------------------------------
# Function to be added to the chpwd_functions array.
# This function is executed whenever the directory is changed.
auto_venv_activate() {
  # If we are in a directory with a .venv and a pyproject.toml or requirements.txt
  if [ -d ".venv" ] && ( [ -f "pyproject.toml" ] || [ -f "requirements.txt" ] ); then
    # And the virtual environment is not already active
    if [ -z "$VIRTUAL_ENV" ]; then
      echo "Activating virtual environment..."
      source .venv/bin/activate
    fi
  # If we are not in such a directory
  else
    # And a virtual environment is active
    if [ -n "$VIRTUAL_ENV" ]; then
      echo "Deactivating virtual environment..."
      deactivate
    fi
  fi
}

# Add the function to the chpwd_functions array.
# This is an array of functions to be executed when the directory is changed.
# Zsh will execute them in the order they are defined.
chpwd_functions=(${chpwd_functions[@]} "auto_venv_activate")
