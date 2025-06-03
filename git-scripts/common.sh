#!/bin/bash
# Bash equivalents for common Git helper functions

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
