#!/bin/bash
# Bash equivalent of utility-scripts main.ps1

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source all utility scripts
for script in "$SCRIPT_DIR"/*.sh; do
  [ "$script" != "$SCRIPT_DIR/main.sh" ] && source "$script"
done
