function lint:fix {
    # Check if npm or pnpm is available and run the appropriate command for lint:fix
    if (Test-Path "node_modules") {
        if (Test-Path "package.json") {
            $packageJson = Get-Content "package.json" | ConvertFrom-Json
            if ($packageJson.scripts -and $packageJson.scripts."lint:fix") {
                if (Get-Command "pnpm" -ErrorAction SilentlyContinue) {
                    Write-Host "Using pnpm to run lint:fix..." -ForegroundColor Cyan
                    pnpm run lint:fix
                } elseif (Get-Command "npm" -ErrorAction SilentlyContinue) {
                    Write-Host "Using npm to run lint:fix..." -ForegroundColor Cyan
                    npm run lint:fix
                } else {
                    Write-Host "Neither npm nor pnpm is installed." -ForegroundColor Red
                }
            } else {
                Write-Host "'lint:fix' script is missing in package.json." -ForegroundColor Red
            }
        } else {
            Write-Host "No package.json found. Please ensure you are in a valid project directory." -ForegroundColor Red
        }
    } else {
        Write-Host "No node_modules directory found. Please ensure you are in a valid project directory." -ForegroundColor Red
    }
}
