function Scripts-Path {
    # Load paths from .env file
    $envFile = Join-Path $PSScriptRoot "../.env"
    if (Test-Path $envFile) {
        $envContent = Get-Content $envFile | Where-Object { $_ -notmatch '^\s*#' -and $_ -match '=' }
        $envVars = @{}
        foreach ($line in $envContent) {
            if ($line -match '^\s*([^=]+?)\s*=\s*"(.*)"\s*$') {
                $envVars[$Matches[1]] = $Matches[2]
            }
        }
    } else {
        Write-Warning "Environment file not found: $envFile"
        return
    }

    Set-Location $envVars["SCRIPTS_PATH"]
    Write-Host "Switched to custom scripts" -ForegroundColor Green
}