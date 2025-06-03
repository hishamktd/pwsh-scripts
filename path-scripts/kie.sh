#!/bin/bash
# Usage: Source this file to load the kie function, then run kie to switch to KIE project directories.

kie() {
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

  project="$1"
  
  case "$project" in
    "sit")
      cd "$BASH_KIE_SIT_PATH"
      echo -e "\033[0;32mSwitched to SIT\033[0m"
      ;;
    "bee")
      cd "$BASH_KIE_BEE_PATH"
      echo -e "\033[0;32mSwitched to Bee work\033[0m"
      ;;
    "hrms")
      cd "$BASH_KIE_HRMS_PATH"
      echo -e "\033[0;32mSwitched to HRMS\033[0m"
      ;;
    "medidesk")
      cd "$BASH_KIE_MEDIDESK_PATH"
      echo -e "\033[0;32mSwitched to MediDesk\033[0m"
      ;;
    "upa")
      cd "$BASH_KIE_UPCODE_CLOUD_PATH"
      echo -e "\033[0;32mSwitched to Upcode Cloud\033[0m"
      ;;
    "ups")
      cd "$BASH_KIE_UPCODE_STUDENT_PATH"
      echo -e "\033[0;32mSwitched to Upcode student web\033[0m"
      ;;
    *)
      echo "Usage: kie [project]"
      echo "Available projects: sit, bee, hrms, medidesk, upa, ups"
      ;;
  esac
}
