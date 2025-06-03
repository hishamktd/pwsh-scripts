# Git Scripts Documentation

## Overview
This document provides detailed information about all git-related PowerShell scripts in the `git-scripts` folder.

## Scripts

### commit.ps1
* **Purpose**: Provides a simplified git commit workflow with automatic staging and message prompting
* **Usage**: `commit [-message <string>] [-flags <string>]`
* **Parameters**:
  - `-message`: Commit message (optional, will prompt if not provided)
  - `-flags`: Additional git commit flags (optional)
* **Default Parameters**: None required
* **Examples**:
  ```powershell
  commit -message "Initial commit"
  commit -flags "--amend"
  commit # Will prompt for message
  ```

### push
* **Purpose**: Provides a safe git push workflow with branch confirmation and optional flags
* **Usage**: `push [<flags>]`
* **Parameters**:
  - `<flags>`: Any valid git push flags (optional)
* **Default Parameters**: None required
* **Examples**:
  ```powershell
  push
  push --force
  push --tags
  ```
* **Notes**:
  - Will prompt for confirmation when using flags
  - Automatically pushes to current branch on origin

### switch (swap function)
* **Purpose**: Simplifies branch switching with automatic branch creation if it doesn't exist
* **Usage**: `swap [-branch <branchname>]`
* **Parameters**:
  - `-branch`: Name of the branch to switch to (default: "main")
* **Default Parameters**: 
  - `-branch`: "main"
* **Examples**:
  ```powershell
  swap -branch feature/new-login
  swap feature/dashboard  # -branch is positional
  swap                   # Switches to 'main' branch
  ```
* **Notes**:
  - Prompts for confirmation before creating new branches
  - Handles both local and remote branch switching
  - Includes error handling for missing Git installation

### status
* **Purpose**: Provides a comprehensive, colorized git status overview with detailed change information
* **Usage**: `status`
* **Parameters**: None
* **Sections Displayed**:
  1. **Git Status**: Shows modified/untracked files (if any)
  2. **Unstaged Changes**: Displays detailed diff of unstaged changes
  3. **Staged Changes**: Shows changes that are staged for commit
  4. **Branch and Remote Status**: Current branch and tracking information

* **Color Coding**:
  - Current branch: Yellow
  - Remote branches: Magenta
  - Local branches: Cyan
  - Clean working directory: Green
  - Error messages: Red

* **Examples**:
  ```powershell
  status  # Shows complete git status
  ```

* **Notes**:
  - Automatically pages through long diffs
  - Shows clear section headers for better readability
  - Handles missing Git installation gracefully

### fetch
* **Purpose**: Fetches changes from remote repositories with visual feedback
* **Usage**: `fetch [-All]`
* **Parameters**:
  - `-All`: Fetches from all remotes (default: fetches from current remote)
* **Examples**:
  ```powershell
  fetch         # Fetches from current remote
  fetch -All    # Fetches from all remotes
  ```
* **Features**:
  - Shows progress dots while fetching
  - Color-coded output (yellow for progress, green for completion)
  - Runs asynchronously to prevent blocking the terminal

* **Notes**:
  - Automatically removes itself after execution (lazy loading)
  - Handles both single and multiple remote scenarios
  - Provides clear completion message

### working
* **Purpose**: Manages working branches for Git repositories with project-based tracking
* **Usage**: `working [command] [parameters]`

#### Commands:
1. **List Branches** (default)
   ```powershell
   working
   working list
   ```
   Displays all saved working branches for the current project.

2. **Add Current Branch**
   ```powershell
   working add
   ```
   Adds the current Git branch to the working list.

3. **Switch to Branch**
   ```powershell
   working switch <index>
   ```
   Switches to the branch at the specified index.

4. **Remove Branch**
   ```powershell
   working remove <index>
   ```
   Removes the branch at the specified index from the working list.

5. **Clear All Branches**
   ```powershell
   working clear
   ```
   Removes all saved branches for the current project.

#### Features:
- Project-based branch management (automatically detects Git repository)
- Persistent storage of working branches in `git-scripts/working/`
- Color-coded output for better readability
- Prevents duplicate branch entries
- Handles errors for non-Git directories

#### Storage Location:
Branches are stored in: `C:\Users\User\PowerShell\custom-scripts\git-scripts\working\<project-name>.txt`

#### Examples:
```powershell
working         # List all working branches
working add     # Add current branch
working switch 2 # Switch to branch #2
working remove 3 # Remove branch #3
working clear   # Clear all saved branches
```

### log
* **Purpose**: Displays Git commit history with customizable formatting options
* **Usage**: `log [-LogFormat <format>] [-MaxCommits <number>] [-Detailed] [-Graph]`

#### Parameters:
- `-LogFormat <format>`: Specifies the output format (default: "oneline")
  - `oneline`: Compact one-line format (default)
  - `short`: Short format
  - `full`: Full commit details
  - Custom format string (follows git's format specifiers)

- `-MaxCommits <number>`: Maximum number of commits to display (default: 10)

- `-Detailed`: Shows detailed commit information including author, date, and message

- `-Graph`: Displays an ASCII graph of the commit history

#### Default Format:
```
<hash> <author> <date> <message>
```

#### Examples:
```powershell
# Basic usage (last 10 commits in one-line format)
log

# Show last 20 commits
log -MaxCommits 20

# Show detailed commit information
log -Detailed

# Show graphical commit history
log -Graph

# Show full log format
log -LogFormat full

# Show custom format
log -LogFormat "%h - %an, %ar : %s"
```

#### Features:
- Color-coded output for better readability
- Helpful usage examples shown after each execution
- Supports all standard git log format specifiers
- Lazy-loaded for better performance

#### Notes:
- The script automatically removes itself after execution (lazy loading)
- Combines well with other git log options through the format parameter
- Shows the actual git command being executed for transparency

### revert
* **Purpose**: Safely reverts Git commits with logging and error handling
* **Usage**: `revert [[-CommitHash] <string>] [-NoEdit] [-Force]`

#### Parameters:
- `-CommitHash`: (Optional) Specific commit hash to revert (default: HEAD)
- `-NoEdit`: Skip opening the commit message editor
- `-Force`: Force the revert, automatically resolving conflicts with --no-commit

#### Default Behavior:
- If no commit hash is provided, reverts the most recent commit (HEAD)
- Logs all actions to `%USERPROFILE%\scripts_log.txt`
- Uses `--no-edit` flag when `-NoEdit` is specified
- Uses `--no-commit` flag when `-Force` is specified

#### Logging:
All revert operations are logged with timestamps to:
```
%USERPROFILE%\scripts_log.txt
```

#### Examples:
```powershell
# Revert the last commit (with editor for message)
revert

# Revert a specific commit
revert -CommitHash a1b2c3d

# Revert without opening editor
revert -NoEdit

# Force revert with automatic conflict resolution
revert -Force

# Revert a specific commit without editing
revert -CommitHash a1b2c3d -NoEdit
```

#### Notes:
- Uses lazy loading for better performance
- Provides visual feedback during execution
- Automatically logs all revert operations
- Handles errors gracefully
- Shows the actual Git command being executed

### branch (br)
* **Purpose**: Manages Git branches with clipboard integration and numbered listing
* **Alias**: `br` (can be used instead of `branch`)
* **Usage**: `branch [ls]`

#### Commands:
1. **List Branches**
   ```powershell
   branch ls
   br ls  # Using alias
   ```
   - Displays all local branches with numbers
   - Highlights current branch in green
   - Copies the branch list to clipboard

2. **Show Current Branch** (default)
   ```powershell
   branch
   br  # Using alias
   ```
   - Shows the current branch name in green
   - Copies the current branch name to clipboard

#### Features:
- Color-coded output for better visibility
- Automatic clipboard integration
- Numbered branch listing for easy reference
- Lazy-loaded for better performance

#### Examples:
```powershell
# Show current branch and copy to clipboard
br

# List all branches with numbers
br ls

# Using full command name
branch
branch ls
```

#### Notes:
- The branch list includes all local branches
- Current branch is marked with an asterisk (*) and colored green
- Clipboard integration makes it easy to paste branch names
- The `br` alias provides a quick way to access branch commands

### pull
* **Purpose**: Simplifies pulling changes from a remote repository with rebase
* **Usage**: `pull [[-branch] <branchname>]`

#### Parameters:
- `-branch`: Name of the branch to pull from (default: "main")

#### Behavior:
1. Fetches changes from the remote repository
2. Performs a rebase pull from the specified branch
3. Shows colored output for better visibility

#### Examples:
```powershell
# Pull from main branch (default)
pull

# Pull from a specific branch
pull -branch develop
pull develop  # Shorthand syntax
```

#### Notes:
- Uses rebase by default to maintain a clean commit history
- Shows visual feedback in cyan color
- Automatically fetches before pulling to ensure up-to-date information
- Works with any branch in the remote repository

### common.ps1
This script contains several utility functions for common Git operations. All functions are lazy-loaded for better performance.

#### add
* **Purpose**: Stages all changes in the current directory
* **Usage**: `add`
* **Behavior**:
  - Equivalent to `git add .`
  - Stages all new and modified files
  - Automatically removes itself after execution (lazy loading)

#### stash
* **Purpose**: Stashes all changes including untracked files
* **Usage**: `stash`
* **Behavior**:
  - Equivalent to `git stash -u`
  - Saves both staged and unstaged changes
  - Includes untracked files in the stash
  - Automatically removes itself after execution

#### apply
* **Purpose**: Applies the most recent stash
* **Usage**: `apply`
* **Behavior**:
  - Equivalent to `git stash apply`
  - Applies the most recent stash without removing it from the stash list
  - Preserves the stash history
  - Automatically removes itself after execution

#### differ
* **Purpose**: Shows differences between current working tree and a specified branch
* **Usage**: `differ [[-branch] <branchname>]`
* **Parameters**:
  - `-branch`: Branch to compare against (default: "main")
* **Examples**:
  ```powershell
  differ           # Compare with main branch
  differ develop   # Compare with develop branch
  differ -branch feature/xyz  # Compare with feature/xyz branch
  ```
* **Notes**:
  - Shows the diff output in the terminal
  - Uses the system's default pager if output is long
  - Automatically removes itself after execution

### Summary of All Git Scripts

| Command  | Description | Example |
|----------|-------------|----------|
| `add`    | Stage all changes | `add` |
| `apply`  | Apply most recent stash | `apply` |
| `branch` | Manage branches | `branch ls`, `br` |
| `commit` | Commit changes | `commit -m "message"` |
| `differ` | Show changes | `differ develop` |
| `fetch`  | Fetch changes | `fetch -All` |
| `log`    | View commit history | `log -Graph` |
| `pull`   | Pull with rebase | `pull develop` |
| `push`   | Push changes | `push --force` |
| `revert` | Revert commits | `revert -NoEdit` |
| `stash`  | Stash changes | `stash` |
| `status` | Show status | `status` |
| `swap`   | Switch branches | `swap feature/xyz` |
| `working`| Manage working branches | `working add`, `working list` |

This completes the documentation for all Git-related scripts in the repository.
