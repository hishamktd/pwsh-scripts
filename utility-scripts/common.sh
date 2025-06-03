#!/bin/bash
# Usage: Source this file to load the enable_shell_enhancements function, then run enable_shell_enhancements to enable enhancements.

enable_shell_enhancements() {
  # Enable menu-complete for Tab (requires bash >= 4.0)
  bind 'TAB:menu-complete'

  # Enable history search with up/down arrows
  bind '"\e[A":history-search-backward'
  bind '"\e[B":history-search-forward'

  # No direct bash equivalent for ShowToolTips or PredictionSource
  # but bash 5+ has history search and suggestions (enable with bash-preexec or bash-completion if desired)
}
