function count-file {
    param(
        [string[]]$avoidFolder = @(),
        [string[]]$avoidFile = @(),
        [string[]]$onlyFolder = @(),
        [string[]]$onlyFile = @()
    )

    # Normalize paths
    $basePath = Get-Location

    # Get all files recursively
    $files = Get-ChildItem -Path $basePath -Recurse -File

    # Filter: only include files in allowed folders (if specified)
    if ($onlyFolder.Count -gt 0) {
        $files = $files | Where-Object {
            $relativePath = $_.FullName.Substring($basePath.Path.Length)
            $onlyFolder -contains ($relativePath -split '[\\/]' | Where-Object { $_ })[0]
        }
    }

    # Filter: exclude files in avoid folders
    if ($avoidFolder.Count -gt 0) {
        $files = $files | Where-Object {
            $relativePath = $_.FullName.Substring($basePath.Path.Length)
            -not ($avoidFolder | Where-Object { $relativePath -like "*$_*" })
        }
    }

    # Filter: only include specific extensions (if specified)
    if ($onlyFile.Count -gt 0) {
        $files = $files | Where-Object {
            $onlyFile -contains $_.Extension.TrimStart('.')
        }
    }

    # Filter: exclude specific extensions
    if ($avoidFile.Count -gt 0) {
        $files = $files | Where-Object {
            -not ($avoidFile -contains $_.Extension.TrimStart('.'))
        }
    }

    # Output count
    Write-Output $files.Count
}
