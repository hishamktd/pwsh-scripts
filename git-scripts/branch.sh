#!/bin/bash
# Usage: Source this file to load the `branch` function, then use:
#   branch            → show & copy current branch
#   branch -ls        → list local branches & copy
#   branch -r         → list remote branches & copy

branch() {
  GREEN='\033[0;32m'
  WHITE='\033[1;37m'
  CYAN='\033[0;36m'
  YELLOW='\033[1;33m'
  NC='\033[0m'

  # Flags
  LIST_LOCAL=false
  LIST_REMOTE=false

  while [[ $# -gt 0 ]]; do
    case "$1" in
      -ls)
        LIST_LOCAL=true
        shift
        ;;
      -r)
        LIST_REMOTE=true
        shift
        ;;
      *)
        echo -e "${YELLOW}Unknown option: $1${NC}"
        return 1
        ;;
    esac
  done

  if $LIST_LOCAL || $LIST_REMOTE; then
    echo -e "\n${CYAN}Branches:${NC}"
    i=1
    branch_list=""
    branch_command="git branch --list"
    $LIST_REMOTE && branch_command="git branch --list -r"

    while read -r branch; do
      branch_name="${branch//\*/}"
      branch_name="${branch_name// /}"
      prefix="$i. "
      if [[ "$branch" == *"*"* ]]; then
        echo -e "${prefix}${GREEN}${branch_name}${NC}"
      else
        echo -e "${prefix}${WHITE}${branch_name}${NC}"
      fi
      branch_list+="${prefix}${branch_name}\n"
      i=$((i+1))
    done < <($branch_command)

    # Copy to clipboard
    if command -v xclip >/dev/null 2>&1; then
      echo -e "$branch_list" | xclip -selection clipboard
      echo -e "\n${YELLOW}Branch list copied to clipboard!${NC}"
    elif command -v pbcopy >/dev/null 2>&1; then
      echo -e "$branch_list" | pbcopy
      echo -e "\n${YELLOW}Branch list copied to clipboard!${NC}"
    else
      echo -e "${YELLOW}Install xclip or pbcopy to enable clipboard copy.${NC}"
    fi
  else
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    echo -en "Current branch: "
    echo -e "${GREEN}${current_branch}${NC}"

    # Copy to clipboard
    if command -v xclip >/dev/null 2>&1; then
      echo -n "$current_branch" | xclip -selection clipboard
      echo -e "\n${YELLOW}Branch name copied to clipboard!${NC}"
    elif command -v pbcopy >/dev/null 2>&1; then
      echo -n "$current_branch" | pbcopy
      echo -e "\n${YELLOW}Branch name copied to clipboard!${NC}"
    else
      echo -e "${YELLOW}Install xclip or pbcopy to enable clipboard copy.${NC}"
    fi
  fi
}
