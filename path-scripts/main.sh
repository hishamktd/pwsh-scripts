#!/bin/bash
# Usage: Source this file to load all path script functions without executing any commands.
# After sourcing, all functions from individual path scripts will be available to call directly.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source all path script files to make their functions available
for script in ws.sh kie.sh common.sh; do
  if [ -f "$SCRIPT_DIR/$script" ]; then
    source "$SCRIPT_DIR/$script"
  fi
done
