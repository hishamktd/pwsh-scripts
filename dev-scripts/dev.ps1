# Lazy load dev function
$LazyDevFunction = {
    function dev {
        param (
            [switch]$Turbo  # Enable Turbo Mode if the switch is provided
        )

        # Check if package.json exists and contains a dev script
        if (-not (Test-Path "package.json")) {
            Write-Host "No package.json found. Please ensure you are in a valid project directory." -ForegroundColor Red
            return
        }

        if (-not (Test-Path "node_modules")) {
            Write-Host "No node_modules directory found. Run 'npm install' or 'pnpm install' first." -ForegroundColor Red
            return
        }

        # Load package.json lazily
        $packageJson = Get-Content "package.json" -Raw | ConvertFrom-Json

        if (-not ($packageJson.scripts -and $packageJson.scripts.dev)) {
            Write-Host "'dev' script is missing in package.json." -ForegroundColor Red
            return
        }

        # Set the environment variable for Turbo Mode if the -Turbo switch is provided
        if ($Turbo) {
            $env:NEXT_EXPERIMENTAL_TURBOPACK = "true"
            Write-Host "Turbo Mode enabled." -ForegroundColor DarkMagenta
        }

        # Check if pnpm, npm, or yarn is available
        $pnpmCmd = Get-Command "pnpm" -ErrorAction SilentlyContinue
        $npmCmd = Get-Command "npm" -ErrorAction SilentlyContinue
        $yarnCmd = Get-Command "yarn" -ErrorAction SilentlyContinue

        if ($pnpmCmd) {
            Write-Host "Using pnpm to run dev..." -ForegroundColor Cyan
            & pnpm run dev
        } elseif ($npmCmd) {
            Write-Host "Using npm to run dev..." -ForegroundColor Cyan
            & npm run dev
        } elseif ($yarnCmd) {
            Write-Host "Using yarn to run dev..." -ForegroundColor Cyan
            & yarn dev
        } else {
            Write-Host "Neither pnpm, npm, nor yarn is installed." -ForegroundColor Red
        }

        # Clear Turbo Mode environment variable after execution
        if ($Turbo) {
            Remove-Item Env:NEXT_EXPERIMENTAL_TURBOPACK
        }

        # Remove the function after execution
        Remove-Item Function:\dev -ErrorAction SilentlyContinue
    }

    # Replace itself with the actual function after first execution
    Set-Item Function:\dev ${function:dev}
    dev @args
}

# Register the proxy function in the global scope
Set-Item Function:\dev $LazyDevFunction
