#!/bin/bash
# Usage: Source this file to load the count_files function, then run count_files to count files with filters.

count() {
  show_help() {
    cat << EOF
Usage: count_files [options]

Options:
  --avoid-folder <name1,name2,...>   Exclude folders by name (e.g., .git,node_modules)
  --avoid-file <ext1,ext2,...>       Exclude files by extension (e.g., js,jsx)
  --only-folder <name1,name2,...>    Only include files inside these folders (e.g., src,apps)
  --only-file <ext1,ext2,...>        Only include files with these extensions (e.g., ts,tsx)
  -h, --help                         Show this help message
EOF
  }

  # Default values
  avoid_folder=()
  avoid_file=()
  only_folder=()
  only_file=()

  # Parse arguments
  while [[ $# -gt 0 ]]; do
    case $1 in
      --avoid-folder)
        IFS=',' read -r -a avoid_folder <<< "$2"
        shift 2
        ;;
      --avoid-file)
        IFS=',' read -r -a avoid_file <<< "$2"
        shift 2
        ;;
      --only-folder)
        IFS=',' read -r -a only_folder <<< "$2"
        shift 2
        ;;
      --only-file)
        IFS=',' read -r -a only_file <<< "$2"
        shift 2
        ;;
      -h|--help)
        show_help
        return 0
        ;;
      *)
        echo "Unknown option: $1"
        show_help
        return 1
        ;;
    esac
  done

  
count=0

# Find files recursively
while IFS= read -r -d '' file; do
  dir=$(dirname "$file")
  base=$(basename "$file")
  ext="${base##*.}"

  skip=false

  # Only include if in only_folder
  if [[ ${#only_folder[@]} -gt 0 ]]; then
    match=false
    for f in "${only_folder[@]}"; do
      [[ "$dir" == *"$f"* ]] && match=true
    done
    $match || continue
  fi

  # Skip if in avoid_folder
  for f in "${avoid_folder[@]}"; do
    [[ "$dir" == *"$f"* ]] && skip=true
  done
  $skip && continue

  # Only include if in only_file
  if [[ ${#only_file[@]} -gt 0 ]]; then
    match=false
    for e in "${only_file[@]}"; do
      [[ "$ext" == "$e" ]] && match=true
    done
    $match || continue
  fi

  # Skip if in avoid_file
  for e in "${avoid_file[@]}"; do
    [[ "$ext" == "$e" ]] && skip=true
  done
  $skip && continue

  count=$((count+1))
done < <(find . -type f -print0)

echo "Total files: $count"

}