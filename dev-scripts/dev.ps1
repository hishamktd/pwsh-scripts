function dev {
    param (
        [switch]$Turbo  # This switch will be used to enable Turbo Mode
    )

    # Check if package.json exists and contains a dev script
    if (Test-Path "node_modules") {
        if (Test-Path "package.json") {
            $packageJson = Get-Content "package.json" | ConvertFrom-Json
            if ($packageJson.scripts -and $packageJson.scripts.dev) {
                
                # Set the environment variable for Turbo Mode if the -Turbo switch is provided
                if ($Turbo) {
                    $env:NEXT_EXPERIMENTAL_TURBOPACK = "true"
                    Write-Host "Turbo Mode enabled." -ForegroundColor DarkMagenta
                }

                # Check if pnpm or npm is available and run the appropriate command
                if (Get-Command "pnpm" -ErrorAction SilentlyContinue) {
                    Write-Host "Using pnpm to run dev..." -ForegroundColor Cyan
                    pnpm run dev
                } elseif (Get-Command "npm" -ErrorAction SilentlyContinue) {
                    Write-Host "Using npm to run dev..." -ForegroundColor Cyan
                    npm run dev
                } else {
                    Write-Host "Neither npm nor pnpm is installed." -ForegroundColor Red
                }

                # Clear the environment variable after the command finishes
                if ($Turbo) {
                    Remove-Item Env:NEXT_EXPERIMENTAL_TURBOPACK
                }
            } else {
                Write-Host "'dev' script is missing in package.json." -ForegroundColor Red
            }
        } else {
            Write-Host "No package.json found. Please ensure you are in a valid project directory." -ForegroundColor Red
        }
    } else {
        Write-Host "No node_modules directory found. Please ensure you are in a valid project directory." -ForegroundColor Red
    }
}
