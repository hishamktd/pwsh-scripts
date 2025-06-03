#!/bin/bash
# Usage: Source this file to load the log function, then run log to view git commit history.

log() {
  CYAN='\033[0;36m'
  YELLOW='\033[1;33m'
  GREEN='\033[0;32m'
  NC='\033[0m'

  LOG_FORMAT="oneline"
  MAX_COMMITS=10
  DETAILED=false
  GRAPH=false

  while [[ $# -gt 0 ]]; do
    case $1 in
      -LogFormat)
        LOG_FORMAT="$2"
        shift 2
        ;;
      -MaxCommits)
        MAX_COMMITS="$2"
        shift 2
        ;;
      -Detailed)
        DETAILED=true
        shift
        ;;
      -Graph)
        GRAPH=true
        shift
        ;;
      *)
        shift
        ;;
    esac
  done

  case "$LOG_FORMAT" in
    oneline) FORMAT="--oneline" ;;
    short) FORMAT="--short" ;;
    full) FORMAT="--pretty=full" ;;
    *) FORMAT="--pretty=format:'%h %an %ad %s'" ;;
  esac

  if $DETAILED; then
    FORMAT="--pretty=format:'%h %an %ad %s'"
  fi

  if $GRAPH; then
    FORMAT="$FORMAT --graph"
  fi

  echo -e "${CYAN}Showing last $MAX_COMMITS commits:${NC}"
  git log $FORMAT -n $MAX_COMMITS
}

