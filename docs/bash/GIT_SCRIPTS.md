# Git Scripts Documentation (Bash)

## Overview
This document provides detailed information about all git-related Bash scripts in the `git-scripts` folder. These scripts are designed to be sourced rather than executed directly, providing functions that can be called after sourcing.

## How to Use
Source the main.sh file to load all git script functions:
```bash
source /path/to/git-scripts/main.sh
```

Then call any of the functions described below.

## Scripts

### commit.sh
* **Purpose**: Provides a simplified git commit workflow with automatic staging
* **Function**: `git_commit`
* **Usage**: `git_commit [message] [flags]`
* **Parameters**:
  - `message`: Commit message (optional, will prompt if not provided)
  - `flags`: Additional git commit flags (optional)
* **Examples**:
  ```bash
  git_commit "Initial commit"
  git_commit "Fix bug" "--amend"
  git_commit # Will prompt for message
  ```

### push.sh
* **Purpose**: Provides a git push workflow with optional flags
* **Function**: `push`
* **Usage**: `push [flags]`
* **Parameters**:
  - `flags`: Any valid git push flags (optional)
* **Examples**:
  ```bash
  push
  push --force
  push --tags
  ```
* **Notes**:
  - Automatically pushes to current branch on origin

### switch.sh
* **Purpose**: Simplifies branch switching with automatic branch creation if it doesn't exist
* **Function**: `swap`
* **Usage**: `swap [branch]`
* **Parameters**:
  - `branch`: Name of the branch to switch to (default: "main")
* **Examples**:
  ```bash
  swap feature/new-login
  swap # Switches to 'main' branch
  ```
* **Notes**:
  - Will prompt for confirmation to create branch if it doesn't exist

### pull.sh
* **Purpose**: Provides a simplified git pull workflow
* **Function**: `pull`
* **Usage**: `pull`
* **Examples**:
  ```bash
  pull
  ```
* **Notes**:
  - Pulls from the current branch

### branch.sh
* **Purpose**: Display and manage git branches
* **Function**: `git_branch`
* **Usage**: `git_branch [option]`
* **Parameters**:
  - `option`: Optional command (ls, copy)
* **Examples**:
  ```bash
  git_branch        # Shows current branch
  git_branch ls     # Lists all branches
  git_branch copy   # Copies current branch name to clipboard
  ```

### status.sh
* **Purpose**: Provides a detailed git status with color coding
* **Function**: `git_status`
* **Usage**: `git_status`
* **Examples**:
  ```bash
  git_status
  ```

### log.sh
* **Purpose**: Provides a customizable git log view
* **Function**: `log`
* **Usage**: `log [options]`
* **Parameters**:
  - `-LogFormat`: Format of the log (oneline, short, full)
  - `-MaxCommits`: Number of commits to show
  - `-Detailed`: Show detailed log
  - `-Graph`: Show graphical representation
* **Examples**:
  ```bash
  log
  log -LogFormat full
  log -MaxCommits 20
  log -Detailed
  log -Graph
  ```

### revert.sh
* **Purpose**: Revert changes in git repository
* **Function**: `revert`
* **Usage**: `revert [commit]`
* **Parameters**:
  - `commit`: Commit hash to revert (optional, defaults to last commit)
* **Examples**:
  ```bash
  revert
  revert abc123f
  ```

### fetch.sh
* **Purpose**: Fetch changes from remote repository
* **Function**: `git_fetch`
* **Usage**: `git_fetch [--all]`
* **Parameters**:
  - `--all`: Fetch from all remotes (optional)
* **Examples**:
  ```bash
  git_fetch
  git_fetch --all
  ```

### working.sh
* **Purpose**: Manage working branches for projects
* **Function**: `working`
* **Usage**: `working [command] [args]`
* **Parameters**:
  - `command`: One of: add, remove, clear, list, switch, view, help
  - `args`: Arguments for the specific command
* **Examples**:
  ```bash
  working           # Show working branches
  working add       # Add current branch
  working remove    # Remove current branch
  working clear     # Clear all branches
  working list      # List projects
  working switch 2  # Switch to branch #2
  working view      # View branches
  working help      # Show help
  ```

### common.sh
* **Purpose**: Provides common git helper functions
* **Functions**: Various helper functions for other git scripts
* **Usage**: Not called directly, used by other scripts
