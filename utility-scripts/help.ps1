if (-not (Get-Command scripts -ErrorAction SilentlyContinue)) {
    function scripts {
        param([string]$command)

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
            Write-Theme "    add                      - Stage all changes for commit." "Command"
            Write-Theme "    stash                    - Stash all uncommitted changes, including untracked files." "Command"
            Write-Theme "    apply                    - Apply the most recent stash." "Command"
            Write-Theme "    pull                     - Pull the latest changes from the 'main' branch." "Command"
            Write-Theme "    branch                   - Display the current active Git branch." "Command"
            Write-Theme "       ls                      - List all branches in the repo." "SubCommand"
            Write-Theme "    differ [branch]          - Compare the current branch with a specified branch (default: 'main')." "Command"
            Write-Theme "    fetch [--all]            - Fetch changes from the remote repository." "Command"
            Write-Theme "    push [flags]             - Push changes to the current branch on the origin remote." "Command"
            Write-Theme "    status                   - Show detailed Git repository status." "Command"
            Write-Theme "    swap [branch]            - Switch to a branch (default: 'main')." "Command"
            Write-Theme "    log [options]            - View Git commit log with different formats." "Command"
            Write-Theme "    Revert                   - Revert a specific commit or the latest commit." "Command"

            Write-Theme "`n  Working Branch Management:" "Header"
            Write-Theme "    working                  - List working branches." "Command"
            Write-Theme "    working add              - Add the current branch to working branches." "Command"
            Write-Theme "    working remove           - Remove the current branch from working branches." "Command"
            Write-Theme "    working clear            - Clear all saved branches." "Command"
            Write-Theme "    working list             - List all projects with saved branches." "Command"
            Write-Theme "    working switch [n]       - Switch to a branch by its list number." "Command"
            Write-Theme "    working view             - View the project file." "Command"

            Write-Theme "`n  Development:" "Header"
            Write-Theme "    build                    - Build the project using npm or pnpm." "Command"
            Write-Theme "    dev [--Turbo]            - Run the development server using npm or pnpm." "Command"
            Write-Theme "    install-pkg [PkgNames]   - Install specified packages or dependencies." "Command"
            Write-Theme "    lint:fix                 - Run lint fixes automatically." "Command"

            Write-Theme "`n  Utilities:" "Header"
            Write-Theme "    help                     - Show this help message." "Command"
            Write-Theme "    reload                   - Reload the PSReadLine module." "Command"
            Write-Theme "    search [Name]            - Search for files or folders by name." "Search"
        }

        switch ($command) {
            "help" { Show-Help }
            default { Write-Theme "Unknown command. Use 'scripts help' for available commands." "Highlight" }
        }

        # Self-remove after execution
        Remove-Item -Path Function:scripts -ErrorAction SilentlyContinue
    }
}
