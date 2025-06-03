#!/bin/bash
# Usage: Source this file to load the show_tree function, then run show_tree to display the directory tree.

show_tree() {
  local path="${1:-.}"
  local exclude=()
  local indent=${3:-0}
  if [[ -n "$2" ]]; then
    IFS=',' read -r -a exclude <<< "$2"
  fi
  local items=()
  while IFS= read -r -d $'\0' item; do
    items+=("$item")
  done < <(find "$path" -mindepth 1 -maxdepth 1 -type d -print0)
  for item in "${items[@]}"; do
    local name=$(basename "$item")
    if [[ " ${exclude[*]} " == *" $name "* ]]; then
      continue
    fi
    printf "%*s\u2514\u2500 %s\n" "$indent" "" "$name"
    show_tree "$item" "$2" $((indent + 3))
  done
}
