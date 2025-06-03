  #!/bin/bash
# Usage: Source this file to load the enable_oh_my_posh function, then run enable_oh_my_posh to initialize oh-my-posh.

enable_oh_my_posh() {
  CONFIG_PATH="$(dirname "$0")/theme/amro.json"

  if command -v oh-my-posh >/dev/null 2>&1; then
    eval "$(oh-my-posh init bash --config \"$CONFIG_PATH\")"
  else
    echo "oh-my-posh is not installed. Please install oh-my-posh for bash/zsh."
  fi
}
