#!/bin/bash
# Usage: Source this file to load all script functions from subdirectories into your shell. Does not run any logic.
# Bash equivalent of main.ps1 (root)
# Sources main.sh from each subdirectory if it exists, to load functions.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if main.sh exists in the subdirectory before sourcing
if [ -f "$SCRIPT_DIR/utility-scripts/main.sh" ]; then
  source "$SCRIPT_DIR/utility-scripts/main.sh"
fi
if [ -f "$SCRIPT_DIR/git-scripts/main.sh" ]; then
  source "$SCRIPT_DIR/git-scripts/main.sh"
fi
if [ -f "$SCRIPT_DIR/dev-scripts/main.sh" ]; then
  source "$SCRIPT_DIR/dev-scripts/main.sh"
fi
if [ -f "$SCRIPT_DIR/theme-scripts/main.sh" ]; then
  source "$SCRIPT_DIR/theme-scripts/main.sh"
fi
if [ -f "$SCRIPT_DIR/path-scripts/main.sh" ]; then
  source "$SCRIPT_DIR/path-scripts/main.sh"
fi
