#!/bin/bash
# Usage: Source this file to load the help function, then run help to display help.

script-help() {
  cat <<EOF
Usage: Custom-Scripts [command] [options]

Commands:

  Git Operations:
    commit [message] [flags] - Stage all changes and commit with a message.
    add                      - Stage all changes for commit.
    stash                    - Stash all uncommitted changes, including untracked files.
    apply                    - Apply the most recent stash.
    pull                     - Pull the latest changes from the 'main' branch.
    branch                   - Display the current active Git branch.
       ls                      - List all branches in the repo.
    differ [branch]          - Compare the current branch with a specified branch (default: 'main').
    fetch [--all]            - Fetch changes from the remote repository.
    push [flags]             - Push changes to the current branch on the origin remote.
    status                   - Show detailed Git repository status.
    swap [branch]            - Switch to a branch (default: 'main').
    log [options]            - View Git commit log with different formats.
    revert                   - Revert a specific commit or the latest commit.

  Working Branch Management:
    working                  - List working branches.
    working add              - Add the current branch to working branches.
    working remove           - Remove the current branch from working branches.
    working clear            - Clear all saved branches.
    working list             - List all projects with saved branches.
    working switch [n]       - Switch to a branch by its list number.
    working view             - View the project file.

  Utility Scripts:
    count.sh                 - Count files with flexible filters.
    search.sh                - Search for files or content.
    reload.sh                - Reload scripts or shell config.
    show-tree.sh             - Show directory tree structure.

  Path Scripts:
    ws.sh                    - Workspace utilities.
    kie.sh                   - Key environment info.

Use '<command> help' for more details on a specific command.
EOF
}
