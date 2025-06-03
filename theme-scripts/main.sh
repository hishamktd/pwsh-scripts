#!/bin/bash
# Bash equivalent of main.ps1 for theme-scripts
# This script sources oh-my-posh.sh if it exists.

if [ -f "$(dirname "$0")/oh-my-posh.sh" ]; then
  source "$(dirname "$0")/oh-my-posh.sh"
else
  echo "oh-my-posh.sh not found. Please create or install a bash version if needed."
fi
