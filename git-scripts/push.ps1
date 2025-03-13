function push {
    # Get the current branch name
    $currentBranch = git symbolic-ref --short HEAD

    # Check if any flags are passed
    if ($args.Count -gt 0) {
        # Prompt for confirmation if there are flags
        $confirm = Read-Host "Are you sure you want to push to branch '$currentBranch' with flags '$args'? (y/n)"
        if ($confirm -notmatch '^[yY]$') {
            Write-Output "Push canceled."
            return
        }
    }

    # Push to the current branch on origin with any flags passed as arguments
    git push origin $currentBranch $args
}