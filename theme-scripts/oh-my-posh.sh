#!/bin/bash
# Bash equivalent of oh-my-posh.ps1
# Initializes oh-my-posh for bash/zsh with the same config

CONFIG_PATH="$(dirname "$0")/theme/amro.json"

if command -v oh-my-posh >/dev/null 2>&1; then
  eval "$(oh-my-posh init bash --config \"$CONFIG_PATH\")"
else
  echo "oh-my-posh is not installed. Please install oh-my-posh for bash/zsh."
fi
