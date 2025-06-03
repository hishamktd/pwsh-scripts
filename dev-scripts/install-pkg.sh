#!/bin/bash
# Usage: Source this file to load the install_pkg function, then run install_pkg to install packages.

install_pkg() {
  RED='\033[0;31m'
  CYAN='\033[0;36m'
  NC='\033[0m'

  if [ ! -f package.json ]; then
    echo -e "${RED}No package.json found. Please ensure you are in a valid project directory.${NC}"
    return 1
  fi

  # Detect package manager
  if command -v pnpm >/dev/null 2>&1; then
    PKG_MGR="pnpm"
  elif command -v npm >/dev/null 2>&1; then
    PKG_MGR="npm"
  elif command -v yarn >/dev/null 2>&1; then
    PKG_MGR="yarn"
  else
    echo -e "${RED}Neither pnpm, npm, nor yarn is installed.${NC}"
    return 1
  fi

  if [ $# -eq 0 ]; then
    # Install all dependencies
    echo -e "${CYAN}No package names provided. Installing all dependencies...${NC}"
    case "$PKG_MGR" in
      pnpm) pnpm install ;;
      npm) npm install ;;
      yarn) yarn install ;;
    esac
  else
    # Install specified packages
    echo -e "${CYAN}Using $PKG_MGR to install: $*${NC}"
    case "$PKG_MGR" in
      pnpm) pnpm add "$@" ;;
      npm) npm install "$@" ;;
      yarn) yarn add "$@" ;;
    esac
  fi
}
