# Lazy Load Git Log Function
$LazyLogFunction = {
    function log {
        # git-log.ps1

        param(
            [string]$LogFormat = "oneline",  # Default format: oneline
            [int]$MaxCommits = 10,           # Default number of commits: 10
            [switch]$Detailed,               # Detailed log (with author, date, and message)
            [switch]$Graph                   # Graphical view of commit history
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
        Write-Host "Executing Git log command: $logCommand" -ForegroundColor Cyan
        Invoke-Expression $logCommand

        # Show helper text after execution
        Write-Host "`nUsage:" -ForegroundColor Yellow
        Write-Host "log -LogFormat oneline   # Compact log format (default)" -ForegroundColor Green
        Write-Host "log -LogFormat full      # Full log with details" -ForegroundColor Green
        Write-Host "log -MaxCommits 20       # Show last 20 commits" -ForegroundColor Green
        Write-Host "log -Detailed            # Show commit author, date, and message" -ForegroundColor Green
        Write-Host "log -Graph               # Show a graphical commit history" -ForegroundColor Green

        # Remove the function after execution
        Remove-Item Function:\log -ErrorAction SilentlyContinue
    }

    # Replace itself with the actual function after first execution
    Set-Item Function:\log ${function:log}
    log @args
}

# Register the proxy function in the global scope
Set-Item Function:\log $LazyLogFunction
