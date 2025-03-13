function install-pkg {
    param (
        [string[]]$PackageNames = @()                # Array of package names to install, default to empty array
    )

    # Check if package.json exists to confirm it's a Node.js project
    if (Test-Path "package.json") {
        if ($PackageNames.Count -eq 0) {
            # If no package names are provided, run install to install all dependencies
            Write-Host "No package names provided. Installing all dependencies..." -ForegroundColor Cyan
            if (Get-Command "pnpm" -ErrorAction SilentlyContinue) {
                pnpm install
            } elseif (Get-Command "npm" -ErrorAction SilentlyContinue) {
                npm install
            } else {
                Write-Host "Neither npm nor pnpm is installed." -ForegroundColor Red
            }
        } else {
            # Join the package names into a single string for easy command execution
            $packages = $PackageNames -join " "

            if (Get-Command "pnpm" -ErrorAction SilentlyContinue) {
                Write-Host "Using pnpm to install $packages..." -ForegroundColor Cyan
                pnpm add $packages
            } elseif (Get-Command "npm" -ErrorAction SilentlyContinue) {
                Write-Host "Using npm to install $packages..." -ForegroundColor Cyan
                npm install $packages
            } else {
                Write-Host "Neither npm nor pnpm is installed." -ForegroundColor Red
            }
        }
    } else {
        Write-Host "No package.json found. Please ensure you are in a valid project directory." -ForegroundColor Red
    }
}
