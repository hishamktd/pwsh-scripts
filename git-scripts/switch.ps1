function swap {
    param (
        [string]$branch = "main"
    )

    # Check if the branch exists
    $branchExists = git branch --list $branch

    if (-not $branchExists) {
        # Inform the user that the branch doesn't exist, display in red
        Write-Host "Branch '$branch' does not exist." -ForegroundColor Red

        # Prompt for confirmation to create a new branch
        $confirmation = Read-Host "Do you want to create it? (y/n)"

        if ($confirmation -eq "y") {
            # Create and switch to the branch, display success in green
            Write-Host "Creating and switching to branch '$branch'..." -ForegroundColor Cyan
            git switch -c $branch
            Write-Host "Switched to new branch '$branch'." -ForegroundColor Green
        } else {
            # Display cancellation message in yellow
            Write-Host "Branch creation canceled." -ForegroundColor Yellow
        }
    }
    else {
        # Switch to the branch if it exists, display in cyan
        Write-Host "Switching to branch '$branch'..." -ForegroundColor Cyan
        git switch $branch
    }
}
