$LazySwapFunction = {
    function swap {
        param (
            [string]$branch = ""
        )

        # Ensure Git is installed
        if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
            Write-Host "`e[1;31mError: Git is not installed or not found in the system path.`e[0m"
            Remove-Item Function:\swap -ErrorAction SilentlyContinue
            return
        }

        # Ensure a branch name is provided
        if (-not $branch) {
            Write-Host "`e[1;31mError: No branch name provided. Usage: swap <branch-name>`e[0m"
            Remove-Item Function:\swap -ErrorAction SilentlyContinue
            return
        }

        # Get a clean list of local branches
        $branches = git branch --format="%(refname:short)" | ForEach-Object { $_.Trim() }

        if ($branches.Count -eq 0) {
            Write-Host "`e[1;31mNo branches found in the repository.`e[0m"
            Remove-Item Function:\swap -ErrorAction SilentlyContinue
            return
        }
        
        # Check if branch exists
        if ($branches -contains $branch) {
            Write-Host "`e[1;36mSwitching to branch '$branch'...`e[0m"
            git switch $branch
        } else {
            $confirmation = Read-Host "`e[1;33mBranch '$branch' does not exist. Do you want to create it? (Y/n)`e[0m"
            if ([string]::IsNullOrWhiteSpace($confirmation) -or $confirmation -match "(?i)^y(es)?$") {
                Write-Host "`e[1;36mCreating and switching to branch '$branch'...`e[0m"
                git switch -c $branch
            } else {
                Write-Host "`e[1;31mOperation canceled.`e[0m"
            }
        }

        # Remove function after execution
        Remove-Item Function:\swap -ErrorAction SilentlyContinue
    }

    # Replace itself with the actual function after first execution
    Set-Item Function:\swap ${function:swap}
    swap @args
}

# Register the function
Set-Item Function:\swap $LazySwapFunction