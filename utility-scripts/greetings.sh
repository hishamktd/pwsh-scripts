#!/bin/bash

# Dynamic greeting
hour=$(date +"%H")
user=$USER
greeting=""

if [ "$hour" -lt 12 ]; then
  greeting="🌅 Good Morning"
elif [ "$hour" -lt 17 ]; then
  greeting="🌞 Good Afternoon"
else
  greeting="🌙 Good Evening"
fi

# System info
cwd=$(pwd)
cpu=$(lscpu | grep "Model name" | awk -F ':' '{print $2}' | sed 's/^ *//')
ram=$(free -h | grep Mem | awk '{print $2}')

# Git branch
git_branch=""
if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  git_branch=$(git branch --show-current)
fi

# Colors
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
MAGENTA='\033[0;35m'
BLUE='\033[0;34m'
NC='\033[0m' # No color

# Display
echo -e "${CYAN}✨ $greeting, $user 🚀${NC}"
echo -e "${YELLOW}📂 Location:${NC} $cwd"
echo -e "${GREEN}🧠 CPU:${NC} $cpu"
echo -e "${MAGENTA}💾 RAM:${NC} $ram"
if [ -n "$git_branch" ]; then
  echo -e "${BLUE}🌿 Git Branch:${NC} $git_branch"
fi
echo ""
