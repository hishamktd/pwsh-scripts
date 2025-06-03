#!/bin/bash
# Bash equivalent of log.ps1

CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

LOG_FORMAT="oneline"
MAX_COMMITS=10
DETAILED=false
GRAPH=false

while [[ $# -gt 0 ]]; do
  case $1 in
    -LogFormat)
      LOG_FORMAT="$2"
      shift 2
      ;;
    -MaxCommits)
      MAX_COMMITS="$2"
      shift 2
      ;;
    -Detailed)
      DETAILED=true
      shift
      ;;
    -Graph)
      GRAPH=true
      shift
      ;;
    *)
      shift
      ;;
  esac
done

case "$LOG_FORMAT" in
  oneline) FORMAT="--oneline" ;;
  short) FORMAT="--short" ;;
  full) FORMAT="--pretty=full" ;;
  *) FORMAT="--pretty=format:'%h %an %ad %s'" ;;
esac

if $DETAILED; then
  FORMAT="--pretty=format:'%h %an %ad %s'"
fi

if $GRAPH; then
  FORMAT="$FORMAT --graph"
fi

LOG_CMD="git log $FORMAT -n $MAX_COMMITS"
echo -e "${CYAN}Executing Git log command: $LOG_CMD${NC}"
eval $LOG_CMD

echo -e "\n${YELLOW}Usage:${NC}"
echo -e "${GREEN}log.sh -LogFormat oneline   # Compact log format (default)${NC}"
echo -e "${GREEN}log.sh -LogFormat full      # Full log with details${NC}"
echo -e "${GREEN}log.sh -MaxCommits 20       # Show last 20 commits${NC}"
echo -e "${GREEN}log.sh -Detailed            # Show commit author, date, and message${NC}"
echo -e "${GREEN}log.sh -Graph               # Show a graphical commit history${NC}"
