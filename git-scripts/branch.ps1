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
}
