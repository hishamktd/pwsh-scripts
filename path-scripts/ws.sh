#!/bin/bash
# Usage: Source this file to load the ws function, then run ws to switch to workspace.

ws() {
  # Load paths from .env file
  ENV_FILE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/.env"
  
  if [ -f "$ENV_FILE" ]; then
    # Source the env file to get the variables
    while IFS='=' read -r key value; do
      # Skip comments and empty lines
      if [[ $key =~ ^#.*$ ]] || [[ -z $key ]]; then
        continue
      fi
      # Remove quotes from the value
      value=$(echo "$value" | sed 's/^"//;s/"$//')
      # Export the variable
      export "$key"="$value"
    done < "$ENV_FILE"
  else
    echo "Environment file not found: $ENV_FILE"
    return 1
  fi

  cd "$BASH_WORKSPACE_PATH"
  echo -e "\033[0;32mSwitched to workspace\033[0m"
}
