function pull {
    param (
        [string]$branch = "main"
    )
    Write-Host "Pulling from origin/$branch..." -ForegroundColor Cyan
    git fetch origin
    git pull origin $branch --rebase
}

Set-Item Function:\pull ${function:pull}
