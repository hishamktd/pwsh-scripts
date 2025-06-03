#!/bin/bash
# Usage: Source this file to load the fetch function, then run fetch to fetch changes.

fetch() {
  YELLOW='\033[1;33m'
  GREEN='\033[0;32m'
  NC='\033[0m'

  ALL=false
  for arg in "$@"; do
    if [[ "$arg" == "-All" || "$arg" == "--All" ]]; then
      ALL=true
    fi
  done

  echo -e "${YELLOW}Fetching...${NC}"

  if $ALL; then
    git fetch --all &
  else  
    git fetch &
  fi
  FETCH_PID=$!

  # Show loading dots while fetching
  while kill -0 $FETCH_PID 2>/dev/null; do
    echo -ne "."
    sleep 1
  done
  wait $FETCH_PID

  echo -e "\n${GREEN}Git fetch completed.${NC}"
}
