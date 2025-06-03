#!/bin/bash
# Bash equivalent of common.ps1 for shell navigation enhancements

# Enable menu-complete for Tab (requires bash >= 4.0)
bind 'TAB:menu-complete'

# Enable history search with up/down arrows
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

# No direct bash equivalent for ShowToolTips or PredictionSource
# but bash 5+ has history search and suggestions (enable with bash-preexec or bash-completion if desired)
