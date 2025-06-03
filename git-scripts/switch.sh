#!/bin/bash
# Usage: Source this file to load the swap function, then run swap to switch git branches.

swap() {
  RED='\033[1;31m'
  CYAN='\033[1;36m'
  YELLOW='\033[1;33m'
  NC='\033[0m'

  branch="main"
  if [ $# -gt 0 ]; then
    branch="$1"
  fi

  if ! command -v git >/dev/null 2>&1; then
    echo -e "${RED}Error: Git is not installed or not found in the system path.${NC}"
    return 1
  fi

  if [ -z "$branch" ]; then
    echo -e "${RED}Error: No branch name provided. Usage: swap <branch-name>${NC}"
    return 1
  fi

  branches=$(git branch --format="%(refname:short)" | sed 's/^ *//;s/ *$//')
  if [ -z "$branches" ]; then
    echo -e "${RED}No branches found in the repository.${NC}"
    return 1
  fi

  if echo "$branches" | grep -qx "$branch"; then
    echo -e "${CYAN}Switching to branch '$branch'...${NC}"
    git switch "$branch"
  else
    echo -en "${YELLOW}Branch '$branch' does not exist. Do you want to create it? (Y - default/n): ${NC}"
    read -r confirmation
    if [ -z "$confirmation" ] || [[ "$confirmation" =~ ^[yY](es)?$ ]]; then
      echo -e "${CYAN}Creating and switching to branch '$branch'...${NC}"
      git switch -c "$branch"
    else
      echo -e "${RED}Operation canceled.${NC}"
    fi
  fi
}
