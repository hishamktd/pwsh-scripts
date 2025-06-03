#!/bin/bash
# Bash equivalent of commit.ps1

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

MESSAGE=""
FLAGS=""

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -m|--message)
      MESSAGE="$2"
      shift 2
      ;;
    --flags)
      FLAGS="$2"
      shift 2
      ;;
    *)
      if [ -z "$MESSAGE" ]; then
        MESSAGE="$1"
      else
        FLAGS+=" $1"
      fi
      shift
      ;;
  esac
done

if [ -z "$MESSAGE" ]; then
  read -rp "Please enter a commit message: " MESSAGE
fi

git add .
if [ $? -eq 0 ]; then
  echo -e "${GREEN}Files staged successfully${NC}"
  STATUS=$(git status --porcelain)
  if [ -n "$STATUS" ]; then
    git commit -m "$MESSAGE" $FLAGS
    if [ $? -eq 0 ]; then
      echo -e "${GREEN}Commit successful!${NC}"
    else
      echo -e "${RED}Commit failed!${NC}"
    fi
  else
    echo -e "${YELLOW}No changes to commit. Working tree is clean.${NC}"
  fi
else
  echo -e "${RED}Failed to stage files for commit${NC}"
fi
