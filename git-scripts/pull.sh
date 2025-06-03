#!/bin/bash
# Usage: Source this file to load the pull function, then run pull to pull from remote.

pull() {
  CYAN='\033[0;36m'
  NC='\033[0m'

  branch="main"
  if [ $# -gt 0 ]; then
    branch="$1"
  fi

  echo -e "${CYAN}Pulling from origin/$branch...${NC}"
  git fetch origin
  git pull origin "$branch" --rebase
}
