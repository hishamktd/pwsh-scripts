#!/bin/bash
# Bash equivalent of working.ps1
directory="$HOME/PowerShell/custom-scripts/git-scripts/working"
mkdir -p "$directory"

get_project_name() {
  git_root=$(git rev-parse --show-toplevel 2>/dev/null)
  if [ $? -ne 0 ]; then
    echo "Not inside a git repository." >&2
    exit 1
  fi
  basename "$git_root"
}

project_name=$(get_project_name)
file_path="$directory/$project_name.txt"
branch=$(git rev-parse --abbrev-ref HEAD 2>&1)
if [[ "$branch" =~ fatal ]]; then
  echo "Not inside a git repository." >&2
  exit 1
fi

show_branches() {
  if [ -f "$file_path" ]; then
    echo "Working branches listed in $project_name:"
    mapfile -t branches < "$file_path"
    if [ ${#branches[@]} -eq 0 ]; then
      echo "No branches saved."
    else
      i=1
      for b in "${branches[@]}"; do
        echo "$i. $b"
        ((i++))
      done
    fi
  else
    echo "No branches saved."
  fi
}

add_branch() {
  touch "$file_path"
  if ! grep -Fxq "$branch" "$file_path"; then
    echo "$branch" >> "$file_path"
    echo "Working branch '$branch' added to $project_name."
  else
    echo "Branch '$branch' is already in $project_name."
  fi
}

remove_branch() {
  if [ -f "$file_path" ]; then
    if grep -Fxq "$branch" "$file_path"; then
      grep -Fxv "$branch" "$file_path" > "$file_path.tmp" && mv "$file_path.tmp" "$file_path"
      echo "Working branch '$branch' removed from $project_name."
      if [ ! -s "$file_path" ]; then
        rm "$file_path"
        echo "File $project_name.txt is empty and has been deleted."
      fi
    else
      echo "Branch '$branch' is not a working branch in $project_name."
    fi
  else
    echo "No file found for this project: $project_name."
  fi
}

view_branches() {
  if [ -f "$file_path" ]; then
    cat "$file_path"
  else
    echo "No file found for this project: $project_name."
  fi
}

clear_branches() {
  if [ -f "$file_path" ]; then
    rm "$file_path"
    echo "All branches cleared for $project_name."
  else
    echo "No branches to clear for $project_name."
  fi
}

list_projects() {
  shopt -s nullglob
  project_files=("$directory"/*.txt)
  if [ ${#project_files[@]} -eq 0 ]; then
    echo "No projects with saved branches."
  else
    echo "Projects with saved branches:"
    for file in "${project_files[@]}"; do
      echo "- $(basename "${file%.txt}")"
    done
  fi
  shopt -u nullglob
}

switch_branch() {
  if [ ! -f "$file_path" ]; then
    echo "No branches saved for this project."
    return
  fi
  mapfile -t branch_list < "$file_path"
  if ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "Please provide a valid branch number."
    return
  fi
  branch_index=$(( $1 - 1 ))
  if [ $branch_index -lt 0 ] || [ $branch_index -ge ${#branch_list[@]} ]; then
    echo "Invalid branch number."
    return
  fi
  target_branch="${branch_list[$branch_index]}"
  target_branch="${target_branch//[$'\t\n\r ']}/" # trim whitespace
  echo "Switching to branch '$target_branch'..."
  git checkout "$target_branch"
}

show_help() {
  echo "Usage: working [command]"
  echo "Commands:"
  echo "  add        - Add the current branch to the working branches list."
  echo "  remove     - Remove the current branch from the working branches list."
  echo "  clear      - Clear all saved branches for the current project."
  echo "  list       - List all projects with saved branches."
  echo "  switch [n] - Switch to a branch by its list number (from 'working' list)."
  echo "  view       - View the project file."
  echo "  help       - Show this help message."
}

case "$1" in
  "" ) show_branches ;;
  add ) add_branch ;;
  remove ) remove_branch ;;
  clear ) clear_branches ;;
  list ) list_projects ;;
  switch ) switch_branch "$2" ;;
  view ) view_branches ;;
  help ) show_help ;;
  * ) show_branches ;;
esac
