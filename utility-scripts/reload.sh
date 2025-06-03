#!/bin/bash
# Bash equivalent of reload.ps1
# Note: Disabling a screen reader is platform-specific and not generally safe from bash.
# This script will attempt to reload bashrc/profile and re-source completion if possible.

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
