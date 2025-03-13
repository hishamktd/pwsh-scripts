function scripts {

    # Define color styles in variables
    $theme = @{
        Title = "DarkGray"
        Header = "Cyan"
        Command = "Green"
        SubCommand = "Gray"
        Highlight = "Magenta"
        Search = "Yellow"
    }

    # Function to write text with theme styles
    function Write-Theme {
        param (
            [string]$text,
            [string]$style
        )
        Write-Host $text -ForegroundColor $theme[$style]
    }

    function Show-Help {
        Write-Theme "Usage: Custom-Scripts [command] [options]" "Title"
        Write-Theme "Commands:" "Title"

        Write-Theme "`n  Git Operations:" "Header"
        Write-Theme "    commit [message] [flags] - Stage all changes and commit with a message." "Command"
        Write-Theme "                               - If no message is provided, you will be prompted to enter one." "SubCommand"
        Write-Theme "                               - Optional flags can be included to modify the commit command (e.g., --amend)." "SubCommand"
        Write-Theme "                               - Usage Example: commit 'Initial commit' --amend" "SubCommand"
        Write-Theme "    add                      - Stage all changes for commit." "Command"
        Write-Theme "    stash                    - Stash all uncommitted changes, including untracked files." "Command"
        Write-Theme "    apply                    - Apply the most recent stash." "Command"
        Write-Theme "    pull                     - Pull the latest changes from the 'main' branch." "Command"
        Write-Theme "    branch                   - Display the current active Git branch." "Command"
        Write-Theme "       ls                      - List all the branch in the repo." "SubCommand"
        Write-Theme "    differ [branch]          - Compare the current branch with the specified branch (default: 'main')." "Command"
        Write-Theme "    fetch [--all]            - Fetch changes from the remote repository." "Command"
        Write-Theme "                               - Use the '--all' switch to fetch from all remotes (instead of the default origin)." "SubCommand"
        Write-Theme "    push [flags]             - Push changes to the current branch on the origin remote." "Command"
        Write-Theme "                               - If flags are provided, you will be prompted for confirmation before pushing." "Command"
        Write-Theme "    status                   - Show the detailed status of the current Git repository." "Command"
        Write-Theme "                               - Displays information about unstaged and staged changes, branch status, remote status, and ahead/behind count relative to 'main'." "SubCommand"
        Write-Theme "                               - The output is styled with colors for easy readability (e.g., yellow for current branch, magenta for remote branches)." "SubCommand"
        Write-Theme "    swap [branch]            - Switch to the specified branch (default: 'main')." "Command"
        Write-Theme "                               - If the branch doesn't exist, you will be prompted to create it." "SubCommand"
        Write-Theme "    log [options]            - View the Git commit log with customizable formats and options." "Command"
        Write-Theme "       [LogFormat]             - The format of the commit log (optional, default is 'oneline')." "SubCommand"
        Write-Theme "                               - Options: 'oneline', 'short', 'full'." "SubCommand"
        Write-Theme "       [MaxCommits]            - The maximum number of commits to display (optional, default is 10)." "SubCommand"
        Write-Theme "       [Detailed]              - Include detailed log information (author, date, and message)." "SubCommand"
        Write-Theme "       [Graph]                 - Show a graphical representation of the commit history." "SubCommand"
        Write-Theme "    Revert                   - Reverts a specific commit or the latest commit in Git." "Command"
        Write-Theme "       Options:" "SubCommand"
        Write-Theme "           [string] CommitHash - Specify the commit hash to revert to. If not provided, defaults to the latest commit (HEAD)." "SubCommand"
        Write-Theme "           [switch] NoEdit     - Skip editing the commit message when reverting." "SubCommand"
        Write-Theme "           [switch] Force      - Force the revert operation if there are conflicts. This prevents Git from creating a commit." "SubCommand"
        

        Write-Theme "`n  Working Branch Management:" "Header"
        Write-Theme "    working                  - List the branches in working branches." "Command"
        Write-Theme "    working add              - Add the current branch to the working branches list." "Command"
        Write-Theme "    working remove           - Remove the current branch from the working branches list." "Command"
        Write-Theme "    working clear            - Clear all saved branches for the current project." "Command"
        Write-Theme "    working list             - List all projects with saved branches." "Command"
        Write-Theme "    working switch [n]       - Switch to a branch by its list number (from 'working' list)." "Command"
        Write-Theme "    working view             - View the project file" "Command"

        Write-Theme "`n  Development:" "Header"
        Write-Theme "    build                    - Build the project using npm or pnpm." "Command"
        Write-Theme "                               - Checks for the presence of 'package.json' and 'build' script." "SubCommand"
        Write-Theme "                               - If npm or pnpm is available, it will run the build script." "SubCommand"
        Write-Theme "                               - If neither npm nor pnpm is installed, an error message will be displayed." "SubCommand"
        Write-Theme "    dev [--Turbo]            - Run the development server using npm or pnpm." "Command"
        Write-Theme "                               - Checks for the presence of 'package.json' and 'dev' script." "SubCommand"
        Write-Theme "                               - If npm or pnpm is available, it will run the dev script." "SubCommand"
        Write-Theme "                               - Use the '--Turbo' switch to enable Turbo Mode (for improved development experience)." "SubCommand"
        Write-Theme "    install-pkg [PkgNames]   - Install the specified packages or all dependencies." "Command"
        Write-Theme "                               - If no package names are provided, installs all dependencies listed in package.json." "SubCommand"
        Write-Theme "                               - If package names are provided, installs those specific packages using npm or pnpm." "SubCommand"
        Write-Theme "    lint:fix                 - Runs the 'lint:fix' script from package.json to automatically fix linting issues." "Command"
        Write-Theme "                               - Uses npm or pnpm to run the 'lint:fix' script, depending on availability." "SubCommand"

        Write-Theme "`n  Utilities:" "Header"
        Write-Theme "    help                     - Show this help message." "Command"
        Write-Theme "    reload                   - Disable the screen reader and reload the PSReadLine module." "Command"
        Write-Theme "    search [Name]            - Search for files or folders by name." "Search"
        Write-Theme "       [Name]                   - The name or pattern to search for (mandatory)." "SubCommand"
        Write-Theme "       [Path]                   - The path to search in (optional, default is current directory)." "SubCommand"
        Write-Theme "       [C]                      - Enable case-sensitive search (optional)." "SubCommand"
        Write-Theme "       [F]                      - Enable full word matching (optional)." "SubCommand"
        Write-Theme "       [Type]                   - The type of item to search for (optional, default is 'Both')." "SubCommand"
        Write-Theme "                               - Options: 'File', 'Folder', 'Both'." "SubCommand"
    }

    switch($args[0]) {
        "help" { Show-Help }
        default { scripts-path }
    }
}
