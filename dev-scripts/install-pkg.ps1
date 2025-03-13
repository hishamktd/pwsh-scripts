# Lazy load install-pkg function
$LazyInstallFunction = {
    function install-pkg {
        param (
            [string[]]$PackageNames = @()  # Array of package names to install
        )

        # Check if package.json exists
        if (-not (Test-Path "package.json")) {
            Write-Host "No package.json found. Please ensure you are in a valid project directory." -ForegroundColor Red
            return
        }

        # Detect package manager
        $pnpmCmd = Get-Command "pnpm" -ErrorAction SilentlyContinue
        $npmCmd = Get-Command "npm" -ErrorAction SilentlyContinue
        $yarnCmd = Get-Command "yarn" -ErrorAction SilentlyContinue

        if ($PackageNames.Count -eq 0) {
            # Install all dependencies if no specific package names are given
            Write-Host "No package names provided. Installing all dependencies..." -ForegroundColor Cyan
            if ($pnpmCmd) {
                & pnpm install
            } elseif ($npmCmd) {
                & npm install
            } elseif ($yarnCmd) {
                & yarn install
            } else {
                Write-Host "Neither pnpm, npm, nor yarn is installed." -ForegroundColor Red
            }
        } else {
            # Install specified packages
            $packages = $PackageNames -join " "
            if ($pnpmCmd) {
                Write-Host "Using pnpm to install: $packages" -ForegroundColor Cyan
                & pnpm add $packages
            } elseif ($npmCmd) {
                Write-Host "Using npm to install: $packages" -ForegroundColor Cyan
                & npm install $packages
            } elseif ($yarnCmd) {
                Write-Host "Using yarn to install: $packages" -ForegroundColor Cyan
                & yarn add $packages
            } else {
                Write-Host "Neither pnpm, npm, nor yarn is installed." -ForegroundColor Red
            }
        }

        # Remove the function after execution
        Remove-Item Function:\install-pkg -ErrorAction SilentlyContinue
    }

    # Replace itself with the actual function after first execution
    Set-Item Function:\install-pkg ${function:install-pkg}
    install-pkg @args
}

# Register the proxy function in the global scope
Set-Item Function:\install-pkg $LazyInstallFunction
