# Lazy load build function
$LazyBuildFunction = {
    function build {
        # Check for package.json and node_modules early
        if (-not (Test-Path "package.json")) {
            Write-Host "No package.json found. Please ensure you are in a valid project directory." -ForegroundColor Red
            return
        }

        if (-not (Test-Path "node_modules")) {
            Write-Host "No node_modules directory found. Run 'npm install' or 'pnpm install' first." -ForegroundColor Red
            return
        }

        # Lazy load package.json only if needed
        $packageJson = Get-Content "package.json" -Raw | ConvertFrom-Json

        if (-not ($packageJson.scripts -and $packageJson.scripts.build)) {
            Write-Host "'build' script is missing in package.json." -ForegroundColor Red
            return
        }

        # Lazy check for package managers
        $pnpmCmd = Get-Command "pnpm" -ErrorAction SilentlyContinue
        $npmCmd = Get-Command "npm" -ErrorAction SilentlyContinue
        $yarnCmd = Get-Command "yarn" -ErrorAction SilentlyContinue

        # Execute the build using the preferred package manager
        if ($pnpmCmd) {
            Write-Host "Using pnpm to build..." -ForegroundColor Cyan
            & pnpm run build
        } elseif ($npmCmd) {
            Write-Host "Using npm to build..." -ForegroundColor Cyan
            & npm run build
        } elseif ($yarnCmd) {
            Write-Host "Using yarn to build..." -ForegroundColor Cyan
            & yarn build
        } else {
            Write-Host "Neither pnpm, npm, nor yarn is installed." -ForegroundColor Red
        }

        # Remove the function after execution
        Remove-Item Function:\build -ErrorAction SilentlyContinue
    }

    # Replace itself with the actual function after first execution
    Set-Item Function:\build ${function:build}
    build @args
}

# Register the proxy function in the global scope
Set-Item Function:\build $LazyBuildFunction
