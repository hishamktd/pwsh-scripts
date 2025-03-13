# Lazy load commit function
$LazyCommitFunction = {
    function commit {
        param (
            [string]$message,
            [string]$flags = ""
        )

        # If no message is provided, prompt the user to enter one
        if (-not $message) {
            $message = Read-Host "Please enter a commit message"
        }

        # Stage all changes
        git add .

        # Ensure git add was successful
        if ($?) {
            Write-Host "Files staged successfully" -ForegroundColor Green

            # Check if there are any changes to commit
            $status = git status --porcelain
            if ($status) {
                # Commit with the message and optional flags
                $commitCommand = "git commit -m '$message' $flags"

                # Run the commit command
                Invoke-Expression $commitCommand

                # Display commit success message in green
                Write-Host "Commit successful!" -ForegroundColor Green
            } else {
                Write-Host "No changes to commit. Working tree is clean." -ForegroundColor Yellow
            }
        } else {
            Write-Host "Failed to stage files for commit" -ForegroundColor Red
        }

        # Remove the function after execution
        Remove-Item Function:\commit -ErrorAction SilentlyContinue
    }

    # Replace itself with the actual function after first execution
    Set-Item Function:\commit ${function:commit}
    commit @args
}

# Register the proxy function in the global scope
Set-Item Function:\commit $LazyCommitFunction
