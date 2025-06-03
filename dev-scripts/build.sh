#!/bin/bash
# Usage: Source this file to load the build function, then run build to build your project.

build() {
  # Colors
  RED='\033[0;31m'
  CYAN='\033[0;36m'
  YELLOW='\033[1;33m'
  NC='\033[0m' # No Color

  # Check for package.json
  if [ ! -f package.json ]; then
    echo -e "${RED}No package.json found. Please ensure you are in a valid project directory.${NC}"
    return 1
  fi

  # Check for node_modules
  if [ ! -d node_modules ]; then
    echo -e "${RED}No node_modules directory found. Run 'npm install' or 'pnpm install' first.${NC}"
    return 1
  fi

  # Check for build script in package.json
  if ! command -v jq >/dev/null 2>&1; then
    echo -e "${RED}jq is required for this script. Please install jq.${NC}"
    return 1
  fi

  if ! jq -e '.scripts.build' package.json >/dev/null; then
    echo -e "${RED}'build' script is missing in package.json.${NC}"
    return 1
  fi

  # Prefer pnpm, then npm, then yarn
  if command -v pnpm >/dev/null 2>&1; then
    echo -e "${CYAN}Using pnpm to build...${NC}"
    pnpm run build
  elif command -v npm >/dev/null 2>&1; then
    echo -e "${CYAN}Using npm to build...${NC}"
    npm run build
  elif command -v yarn >/dev/null 2>&1; then
    echo -e "${CYAN}Using yarn to build...${NC}"
    yarn build
  else
    echo -e "${RED}Neither pnpm, npm, nor yarn is installed.${NC}"
    return 1
  fi
}
