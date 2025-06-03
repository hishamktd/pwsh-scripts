#!/bin/bash
# Usage: Source this file to load helper git functions: add, stash, apply, differ. Only function definitions are present.

add() {
  git add .
}

stash() {
  git stash -u
}

apply() {
  git stash apply
}

differ() {
  local branch="main"
  if [ $# -gt 0 ]; then
    branch="$1"
  fi
  git diff "$branch"
}
