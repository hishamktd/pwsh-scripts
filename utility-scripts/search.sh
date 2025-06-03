#!/bin/bash
# Usage: Source this file to load the search_files function, then run search_files to search for files or folders.

search() {
  usage() {
    echo "Usage: search_files -n <name> [-p <path>] [-c] [-f] [-t file|folder|both]"
    echo "  -n <name>      Name to search for (required)"
    echo "  -p <path>      Search path (default: .)"
    echo "  -c             Case-sensitive search"
    echo "  -f             Full word match only"
    echo "  -t <type>      Search type: file, folder, or both (default: both)"
    return 1
  }

  name=""
  path="."
  case_sensitive=false
  full_word=false
  type="both"

  while getopts ":n:p:cft:" opt; do
    case $opt in
      n) name="$OPTARG" ;;
      p) path="$OPTARG" ;;
      c) case_sensitive=true ;;
      f) full_word=true ;;
      t) type="$OPTARG" ;;
      *) usage ;;
    esac
  done

  [ -z "$name" ] && usage

  grep_opts="-r"
  [ "$case_sensitive" = false ] && grep_opts+="i"

  pattern="$name"
  [ "$full_word" = true ] && pattern="\\b$name\\b"

  case "$type" in
    file)
      find "$path" -type f | xargs grep $grep_opts -l -E "$pattern"
      ;;
    folder)
      find "$path" -type d -name "*$name*"
      ;;
    both)
      find "$path" \( -type f -o -type d \) | grep -E "$pattern"
      ;;
    *)
      usage
      ;;
  esac
}
