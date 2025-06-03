#!/bin/bash
# Usage: Source this file to load all script functions from subdirectories into your shell. Does not run any logic.
# Bash equivalent of main.ps1 (root)
# Sources main.sh from each subdirectory if it exists, to load functions.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for sub in git-scripts dev-scripts utility-scripts theme-scripts; do
  if [ -f "$SCRIPT_DIR/$sub/main.sh" ]; then
    source "$SCRIPT_DIR/$sub/main.sh"
  fi
done
