# Lazy load branch function
$LazyBranchFunction = {
    function branch {
        param (
            [switch]$ls,
            [switch]$r
        )

        if ($ls -or $r) {
            $branches = if ($r) {
                git branch --list -r
            } else {
                git branch --list
            }

            Write-Host "`nBranches:" -ForegroundColor Cyan
            $branchList = ""
            $branchLines = $branches -split "`r?`n"

            for ($i = 0; $i -lt $branchLines.Count; $i++) {
                $branchName = $branchLines[$i].Trim()
                $lineNumber = $i + 1
                $branchList += "$lineNumber. $branchName`n"

                if ($branchName -match '^\*') {
                    Write-Host "$lineNumber. $branchName" -ForegroundColor Green
                } else {
                    Write-Host "$lineNumber. $branchName" -ForegroundColor White
                }
            }

            $branchList | Set-Clipboard
            Write-Host "`nBranch list copied to clipboard!" -ForegroundColor Yellow
        }
        else {
            $currentBranch = git rev-parse --abbrev-ref HEAD
            Write-Host "Current branch: " -NoNewline
            Write-Host "$currentBranch" -ForegroundColor Green

            $currentBranch | Set-Clipboard
            Write-Host "`nBranch name copied to clipboard!" -ForegroundColor Yellow
        }

        # Remove the function after execution
        Remove-Item Function:\branch -ErrorAction SilentlyContinue
        Remove-Item Function:\br -ErrorAction SilentlyContinue
    }

    # Register the function and alias
    Set-Item Function:\branch ${function:branch}
    Set-Alias -Name br -Value branch

    # Call it immediately with passed arguments
    branch @args
}

# Register the proxy in global scope
Set-Item Function:\branch $LazyBranchFunction
Set-Alias -Name br -Value branch
