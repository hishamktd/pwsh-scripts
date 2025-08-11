#!/bin/bash
# Usage: Source this file to load all utility script functions without executing any commands.
# After sourcing, all functions from individual utility scripts will be available to call directly.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source specific utility scripts to make their functions available
for script in common.sh count.sh help.sh reload.sh search.sh size.sh; do
  if [ -f "$SCRIPT_DIR/$script" ]; then
    source "$SCRIPT_DIR/$script"
  fi
done
