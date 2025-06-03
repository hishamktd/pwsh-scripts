#!/bin/bash
# Usage: Source this file to load theme functions. Only sources oh-my-posh.sh if present. Does not run any logic or echo.

if [ -f "$(dirname "$0")/oh-my-posh.sh" ]; then
  source "$(dirname "$0")/oh-my-posh.sh"
fi
