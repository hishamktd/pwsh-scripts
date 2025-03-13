# Lazy Load Git Fetch Function
$LazyFetchFunction = {
    function fetch {
        param (
            [switch]$All
        )

        # Show loading message
        Write-Host "Fetching..." -ForegroundColor Yellow

        # Start a background job for fetching
        $fetchProcess = Start-Process git -ArgumentList "fetch", ($All ? "--all" : "") -PassThru

        # Wait for the process to complete
        while (!$fetchProcess.HasExited) {
            Write-Host "." -NoNewline -ForegroundColor Yellow
            Start-Sleep -Seconds 1
        }

        # Show completion message
        Write-Host "`nGit fetch completed." -ForegroundColor Green

        # Remove the function after execution
        Remove-Item Function:\fetch -ErrorAction SilentlyContinue
    }

    # Replace itself with the actual function after first execution
    Set-Item Function:\fetch ${function:fetch}
    fetch @args
}

# Register the proxy function in the global scope
Set-Item Function:\fetch $LazyFetchFunction
