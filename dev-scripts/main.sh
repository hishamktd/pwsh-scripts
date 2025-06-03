#!/bin/bash
# Bash equivalent of main.ps1 for dev-scripts
# Sources all dev-scripts Bash utilities

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for script in dev.sh build.sh lint-fix.sh install-pkg.sh; do
  if [ -f "$SCRIPT_DIR/$script" ]; then
    source "$SCRIPT_DIR/$script"
  fi
done
