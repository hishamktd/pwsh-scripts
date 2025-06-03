#!/bin/bash
# Usage: Source this file to load all git script functions without executing any commands.
# After sourcing, all functions from individual git scripts will be available to call directly.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source all git script files to make their functions available
for script in commit.sh common.sh push.sh switch.sh status.sh fetch.sh working.sh log.sh revert.sh branch.sh pull.sh; do
  if [ -f "$SCRIPT_DIR/$script" ]; then
    source "$SCRIPT_DIR/$script"
  fi
done