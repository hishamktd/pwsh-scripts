#!/bin/bash
# Bash equivalent of main.ps1 for git-scripts
# Sources all git-scripts Bash utilities

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for script in commit.sh common.sh push.sh switch.sh status.sh fetch.sh working.sh log.sh revert.sh branch.sh pull.sh; do
  if [ -f "$SCRIPT_DIR/$script" ]; then
    source "$SCRIPT_DIR/$script"
  fi
done
