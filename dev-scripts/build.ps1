function build {
    # Check if npm or pnpm is available and run the appropriate command
    if (Test-Path "node_modules") {
        if (Test-Path "package.json") {
            $packageJson = Get-Content "package.json" | ConvertFrom-Json
            if ($packageJson.scripts -and $packageJson.scripts.build) {
                if (Get-Command "pnpm" -ErrorAction SilentlyContinue) {
                    Write-Host "Using pnpm to build..." -ForegroundColor Cyan
                    pnpm run build
                } elseif (Get-Command "npm" -ErrorAction SilentlyContinue) {
                    Write-Host "Using npm to build..." -ForegroundColor Cyan
                    npm run build
                } else {
                    Write-Host "Neither npm nor pnpm is installed." -ForegroundColor Red
                }
            } else {
                Write-Host "'build' script is missing in package.json." -ForegroundColor Red
            }
        } else {
            Write-Host "No package.json found. Please ensure you are in a valid project directory." -ForegroundColor Red
        }
    } else {
        Write-Host "No node_modules directory found. Please ensure you are in a valid project directory." -ForegroundColor Red
    }
}
