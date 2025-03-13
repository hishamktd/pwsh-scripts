# Lazy load branch function
$LazyBranchFunction = {
    function branch {
        param (
            [string]$param
        )

        if ($param -eq 'ls') {
            # List all branches with numbers and style
            $branches = git branch --list
            Write-Host "`nBranches:" -ForegroundColor Cyan
            $branches.Split("`n") | ForEach-Object { 
                $index = [Array]::IndexOf($branches.Split("`n"), $_) + 1
                # Style the branch names with different colors
                $branchName = $_.Trim()
                if ($branchName -match '\*') {
                    # Current branch (marked with *) styled in Green
                    Write-Host "$index. $branchName" -ForegroundColor Green
                }
                else {
                    # Other branches styled in White
                    Write-Host "$index. $branchName" -ForegroundColor White
                }
            }
        }
        else {
            # Get the current branch
            $currentBranch = git rev-parse --abbrev-ref HEAD
            Write-Host "Current branch: " -NoNewline
            Write-Host "$currentBranch" -ForegroundColor Green
        }

        # Remove the function after execution
        Remove-Item Function:\branch -ErrorAction SilentlyContinue
        Remove-Item Function:\br -ErrorAction SilentlyContinue
    }

    # Replace itself with the actual function after first execution
    Set-Item Function:\branch ${function:branch}
    Set-Alias -Name br -Value branch
    branch @args
}

# Register the proxy function in the global scope
Set-Item Function:\branch $LazyBranchFunction
Set-Alias -Name br -Value branch
