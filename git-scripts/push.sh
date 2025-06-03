#!/bin/bash
# Usage: Source this file to load the push function, then run push to push to remote.

push() {
  CYAN='\033[0;36m'
  NC='\033[0m'

  current_branch=$(git symbolic-ref --short HEAD)

  if [ $# -gt 0 ]; then
    echo -n "Are you sure you want to push to branch '$current_branch' with flags '$*'? (y/n): "
    read -r confirm
    if [[ ! "$confirm" =~ ^[yY]$ ]]; then
      echo "Push canceled."
      return 0
    fi
  fi

  echo -e "${CYAN}Pushing to origin/$current_branch...${NC}"
  git push origin "$current_branch" "$@"
}
