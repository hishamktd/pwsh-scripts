#!/bin/bash
# Usage: Source this file to load the status function, then run status to view git status and diffs.

status() {
  RED='\033[1;31m'
  GREEN='\033[1;32m'
  BLUE='\033[1;34m'
  YELLOW='\033[1;33m'
  MAGENTA='\033[35m'
  CYAN='\033[36m'
  NC='\033[0m'

  if ! command -v git >/dev/null 2>&1; then
    echo -e "${RED}Error: Git is not installed or not found in the system path.${NC}"
    return 1
  fi

  echo -e "${BLUE}==== Git Status ====${NC}"
  git_status=$(git status -s)
  if [ -n "$git_status" ]; then
    echo "$git_status"
  else
    echo -e "${GREEN}Clean working directory (no changes).${NC}"
  fi

  echo -e "\n${BLUE}==== Unstaged Changes ====${NC}"
  if git diff --stat | grep -q .; then
    git diff --color | less -R
  else
    echo -e "${GREEN}No unstaged changes found.${NC}"
  fi

  echo -e "\n${BLUE}==== Staged Changes ====${NC}"
  if git diff --cached --stat | grep -q .; then
    git diff --cached --color | less -R
  else
    echo -e "${GREEN}No staged changes found.${NC}"
  fi

  echo -e "\n${BLUE}==== Branch and Remote Status ====${NC}"
  git branch -v | while read -r line; do
    if [[ "$line" =~ ^\* ]]; then
      echo -e "${YELLOW}${line}${NC}"
    elif [[ "$line" =~ origin/ ]]; then
      echo -e "${MAGENTA}${line}${NC}"
    else
      echo -e "${CYAN}${line}${NC}"
    fi
  done
}
