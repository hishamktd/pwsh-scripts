#!/bin/bash
# Usage: Source this file to load the lint_fix function, then run lint_fix to fix lints.

lint:fix() {
  RED='\033[0;31m'
  CYAN='\033[0;36m'
  NC='\033[0m'

  if [ ! -f package.json ]; then
    echo -e "${RED}No package.json found. Please ensure you are in a valid project directory.${NC}"
    return 1
  fi

  if [ ! -d node_modules ]; then
    echo -e "${RED}No node_modules directory found. Please ensure you are in a valid project directory.${NC}"
    return 1
  fi

  if ! command -v jq >/dev/null 2>&1; then
    echo -e "${RED}jq is required for this script. Please install jq.${NC}"
    return 1
  fi

  if ! jq -e '.scripts["lint:fix"]' package.json >/dev/null; then
    echo -e "${RED}'lint:fix' script is missing in package.json.${NC}"
    return 1
  fi

  if command -v pnpm >/dev/null 2>&1; then
    echo -e "${CYAN}Using pnpm to run lint:fix...${NC}"
    pnpm run lint:fix
  elif command -v npm >/dev/null 2>&1; then
    echo -e "${CYAN}Using npm to run lint:fix...${NC}"
    npm run lint:fix
  else
    echo -e "${RED}Neither npm nor pnpm is installed.${NC}"
    return 1
  fi
}
