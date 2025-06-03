#!/bin/bash
# Bash equivalent of revert.ps1

GREEN='\033[0;32m'
NC='\033[0m'
LOG_FILE="$HOME/scripts_log.txt"

commit_hash="HEAD"
NOEDIT=false
FORCE=false

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -NoEdit|--NoEdit)
      NOEDIT=true
      shift
      ;;
    -Force|--Force)
      FORCE=true
      shift
      ;;
    *)
      if [[ -z "$commit_hash" || "$commit_hash" == "HEAD" ]]; then
        commit_hash="$1"
      fi
      shift
      ;;
  esac
done

revert_cmd="git revert $commit_hash"
if $NOEDIT; then
  revert_cmd+=" --no-edit"
fi
if $FORCE; then
  revert_cmd+=" --no-commit"
fi

write_log() {
  local msg="$1"
  local timestamp
  timestamp=$(date '+%Y-%m-%d %H:%M:%S')
  echo -e "[LOG] $msg"
  echo "$timestamp - $msg" >> "$LOG_FILE"
}

write_log "Executing Git revert command: $revert_cmd"
eval $revert_cmd
write_log "Git revert command executed successfully."
