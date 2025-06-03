#!/bin/bash
# Bash equivalent of branch.ps1

GREEN='\033[0;32m'
WHITE='\033[1;37m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

if [[ "$1" == "ls" ]]; then
  echo -e "\n${CYAN}Branches:${NC}"
  i=1
  branch_list=""
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
  done < <(git branch --list)

  # Copy to clipboard (requires xclip or pbcopy)
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
