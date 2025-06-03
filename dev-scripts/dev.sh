#!/bin/bash
# Bash equivalent of dev.ps1

RED='\033[0;31m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m'

TURBO=false

# Parse arguments
for arg in "$@"; do
  case $arg in
    -Turbo|--Turbo)
      TURBO=true
      ;;
  esac
done

if [ ! -f package.json ]; then
  echo -e "${RED}No package.json found. Please ensure you are in a valid project directory.${NC}"
  exit 1
fi

if [ ! -d node_modules ]; then
  echo -e "${RED}No node_modules directory found. Run 'npm install' or 'pnpm install' first.${NC}"
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  echo -e "${RED}jq is required for this script. Please install jq.${NC}"
  exit 1
fi

if ! jq -e '.scripts.dev' package.json >/dev/null; then
  echo -e "${RED}'dev' script is missing in package.json.${NC}"
  exit 1
fi

if $TURBO; then
  export NEXT_EXPERIMENTAL_TURBOPACK=true
  echo -e "${MAGENTA}Turbo Mode enabled.${NC}"
fi

if command -v pnpm >/dev/null 2>&1; then
  echo -e "${CYAN}Using pnpm to run dev...${NC}"
  pnpm run dev
elif command -v npm >/dev/null 2>&1; then
  echo -e "${CYAN}Using npm to run dev...${NC}"
  npm run dev
elif command -v yarn >/dev/null 2>&1; then
  echo -e "${CYAN}Using yarn to run dev...${NC}"
  yarn dev
else
  echo -e "${RED}Neither pnpm, npm, nor yarn is installed.${NC}"
  exit 1
fi

# Unset Turbo env var if set
if $TURBO; then
  unset NEXT_EXPERIMENTAL_TURBOPACK
fi
