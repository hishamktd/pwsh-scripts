# Lazy load lint:fix function
$LazyLintFixFunction = {
    function lint:fix {
        # Check if npm or pnpm is available and run the appropriate command for lint:fix
        if (-not (Test-Path "package.json")) {
            Write-Host "No package.json found. Please ensure you are in a valid project directory." -ForegroundColor Red
            return
        }

        if (-not (Test-Path "node_modules")) {
            Write-Host "No node_modules directory found. Please ensure you are in a valid project directory." -ForegroundColor Red
            return
        }

        # Load package.json lazily
        $packageJson = Get-Content "package.json" -Raw | ConvertFrom-Json

        if (-not ($packageJson.scripts -and $packageJson.scripts."lint:fix")) {
            Write-Host "'lint:fix' script is missing in package.json." -ForegroundColor Red
            return
        }

        # Check for pnpm or npm
        $pnpmCmd = Get-Command "pnpm" -ErrorAction SilentlyContinue
        $npmCmd = Get-Command "npm" -ErrorAction SilentlyContinue

        if ($pnpmCmd) {
            Write-Host "Using pnpm to run lint:fix..." -ForegroundColor Cyan
            & pnpm run lint:fix
        } elseif ($npmCmd) {
            Write-Host "Using npm to run lint:fix..." -ForegroundColor Cyan
            & npm run lint:fix
        } else {
            Write-Host "Neither npm nor pnpm is installed." -ForegroundColor Red
        }

        # Remove the function after execution
        Remove-Item Function:\lint:fix -ErrorAction SilentlyContinue
    }

    # Replace itself with the actual function after first execution
    Set-Item Function:\lint:fix ${function:lint:fix}
    lint:fix @args
}

# Register the proxy function in the global scope
Set-Item Function:\lint:fix $LazyLintFixFunction
