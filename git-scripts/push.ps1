# Lazy Load Git Push Function
$LazyPushFunction = {
    function push {
        # Get the current branch name
        $currentBranch = git symbolic-ref --short HEAD

        # Check if any flags are passed
        if ($args.Count -gt 0) {
            # Prompt for confirmation if there are flags
            $confirm = Read-Host "Are you sure you want to push to branch '$currentBranch' with flags '$args'? (y/n)"
            if ($confirm -notmatch '^[yY]$') {
                Write-Output "Push canceled."
                Remove-Item Function:\push -ErrorAction SilentlyContinue
                return
            }
        }

        # Push to the current branch on origin with any flags passed as arguments
        Write-Host "Pushing to origin/$currentBranch..." -ForegroundColor Cyan
        git push origin $currentBranch $args

        # Remove the function after execution
        Remove-Item Function:\push -ErrorAction SilentlyContinue
    }

    # Replace itself with the actual function after first execution
    Set-Item Function:\push ${function:push}
    push @args
}

# Register the proxy function in the global scope
Set-Item Function:\push $LazyPushFunction
