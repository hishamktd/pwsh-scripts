function log {
    # git-log.ps1

    param(
        [string]$LogFormat = "oneline",  # default format: oneline
        [int]$MaxCommits = 10,           # default number of commits: 10
        [switch]$Detailed,               # Detailed log (with author, date, and message)
        [switch]$Graph                  # Graphical view of commit history
    )

    # Define the Git log format based on the user input
    $format = ""

    switch ($LogFormat) {
        "oneline" { $format = "--oneline" }
        "short" { $format = "--short" }
        "full" { $format = "--pretty=full" }
        default { $format = "--pretty=format:'%h %an %ad %s'" }
    }

    # Check if Detailed or Graph is enabled and modify the format accordingly
    if ($Detailed) {
        $format = "--pretty=format:'%h %an %ad %s'"  # Detailed log format
    }

    # Include graphical view option if selected
    if ($Graph) {
        $format += " --graph"
    }

    # Command to show the Git log with the desired format and maximum commits
    $logCommand = "git log $format -n $MaxCommits"

    # Execute the Git log command and display the result
    Write-Host "Executing Git log command: $logCommand"
    Invoke-Expression $logCommand
}

