# Lazy Load Git Status Function
$LazyStatusFunction = {
    function status {
        # Check if Git is installed
        if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
            Write-Host "`e[1;31mError: Git is not installed or not found in the system path.`e[0m"
            Remove-Item Function:\status -ErrorAction SilentlyContinue
            return
        }

        # Output the status header
        Write-Host "`e[1;34m==== Git Status ====`e[0m"

        # Get status
        $gitStatus = git status -s
        if ($gitStatus) {
            Write-Output $gitStatus
        } else {
            Write-Output "`e[1;32mClean working directory (no changes).`e[0m"
        }

        # Unstaged changes
        Write-Host "`n`e[1;34m==== Unstaged Changes ====`e[0m"
        if (git diff --stat) {
            git diff --color | Out-Host -Paging
        } else {
            Write-Output "`e[1;32mNo unstaged changes found.`e[0m"
        }

        # Staged changes
        Write-Host "`n`e[1;34m==== Staged Changes ====`e[0m"
        if (git diff --cached --stat) {
            git diff --cached --color | Out-Host -Paging
        } else {
            Write-Output "`e[1;32mNo staged changes found.`e[0m"
        }

        # Branch and remote status
        Write-Output "`n`e[1;34m==== Branch and Remote Status ====`e[0m"
        git branch -v | ForEach-Object {
            if ($_ -match '^\*') {
                $_ -replace '^\* (\S+)', "`e[1;33m* $1 `e[0m"  # Current branch in yellow
            }
            elseif ($_ -match 'origin/') {
                $_ -replace '(origin/\S+)', "`e[35m$1`e[0m"    # Remote branches in magenta
            }
            else {
                $_ -replace '^\s+(\S+)', "`e[36m$1`e[0m"       # Local branches in cyan
            }
        } | Out-String | Write-Output

        # Ahead/Behind count
        $aheadBehind = git rev-list --left-right --count main...HEAD
        if ($aheadBehind -match "(\d+)\s+(\d+)") {
            $aheadCount, $behindCount = $matches[1], $matches[2]
            Write-Output "`e[1;34mCurrent branch is ahead by $aheadCount commits and behind by $behindCount commits relative to 'main'.`e[0m"
        } else {
            Write-Output "`e[1;34mCould not determine ahead/behind status. Ensure 'main' exists in your repository.`e[0m"
        }

        # Remove the function after execution
        Remove-Item Function:\status -ErrorAction SilentlyContinue
    }

    # Replace itself with the actual function after first execution
    Set-Item Function:\status ${function:status}
    status @args
}

# Register the proxy function in the global scope
Set-Item Function:\status $LazyStatusFunction
