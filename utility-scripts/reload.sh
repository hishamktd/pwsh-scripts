#!/bin/bash
# Usage: Source this file to load the reload function, then run reload to reload shell configuration.

reload() {
  if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
    echo "~/.bashrc reloaded successfully."
  elif [ -f "$HOME/.bash_profile" ]; then
    source "$HOME/.bash_profile"
    echo "~/.bash_profile reloaded successfully."
  else
    echo "No bashrc or bash_profile found to reload."
  fi

  # Optionally reload bash-completion if available
  if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
    echo "bash_completion reloaded successfully."
  fi
}
