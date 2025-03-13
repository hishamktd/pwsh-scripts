# Lazy Load Git Revert Function
$LazyRevertFunction = {
    function revert {
        param(
            [string]$CommitHash = "",   # Optionally specify a commit hash to revert to
            [switch]$NoEdit,            # Option to skip commit message edit
            [switch]$Force              # Force the revert if there are conflicts
        )

        # Define log file path
        $logFilePath = "$env:USERPROFILE\scripts_log.txt"

        # Function to log messages to both console and file
        function Write-Log {
            param (
                [string]$message
            )

            # Write to console
            Write-Host "[LOG] $message" -ForegroundColor Green

            # Write to log file
            $timestamp = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
            "$timestamp - $message" | Out-File -Append -FilePath $logFilePath
        }

        # If no commit hash is provided, revert the last commit by default
        if (-not $CommitHash) {
            $CommitHash = "HEAD"
        }

        # Build the Git revert command
        $revertCommand = "git revert $CommitHash"

        # Add options if specified
        if ($NoEdit) {
            $revertCommand += " --no-edit"
        }

        if ($Force) {
            $revertCommand += " --no-commit"
        }

        # Log the revert command
        Write-Log "Executing Git revert command: $revertCommand"

        # Execute the revert command
        Invoke-Expression $revertCommand

        # Log successful execution
        Write-Log "Git revert command executed successfully."

        # Remove the function after execution
        Remove-Item Function:\revert -ErrorAction SilentlyContinue
    }

    # Replace itself with the actual function after first execution
    Set-Item Function:\revert ${function:revert}
    revert @args
}

# Register the proxy function in the global scope
Set-Item Function:\revert $LazyRevertFunction
