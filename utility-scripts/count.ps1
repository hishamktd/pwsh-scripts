function count-file {
    param(
        [Parameter(Mandatory = $false)]
        [switch]$Help,

        [string[]]$avoidFolder = @(),
        [string[]]$avoidFile = @(),
        [string[]]$onlyFolder = @(),
        [string[]]$onlyFile = @()
    )

    if ($Help) {
        Write-Host @"
Usage: count-file [options]

Options:
  --avoid-folder <list>   Exclude folders by name (e.g., '.git', 'node_modules')
  --avoid-file <list>     Exclude files by extension (e.g., 'js', 'jsx')
  --only-folder <list>    Only include files inside these folders (e.g., 'src', 'apps')
  --only-file <list>      Only include files with these extensions (e.g., 'ts', 'tsx')
  -Help                   Show this help message
"@
        return
    }

    $basePath = Get-Location
    $files = Get-ChildItem -Path $basePath -Recurse -File

    # Normalize
    $avoidFolder = $avoidFolder | ForEach-Object { $_.ToLower() }
    $onlyFolder  = $onlyFolder  | ForEach-Object { $_.ToLower() }
    $avoidFile   = $avoidFile   | ForEach-Object { $_.ToLower() }
    $onlyFile    = $onlyFile    | ForEach-Object { $_.ToLower() }

    $files = $files | Where-Object {
        $fullPath = $_.FullName.ToLower()
        $dirPath = $_.DirectoryName.ToLower()
        $ext = $_.Extension.TrimStart('.').ToLower()

        # Must be inside one of the "only" folders if specified
        if ($onlyFolder.Count -gt 0) {
            if (-not ($onlyFolder | Where-Object { $dirPath -like "*\$_\*" })) {
                return $false
            }
        }

        # Skip if it's inside a folder to avoid
        if ($avoidFolder.Count -gt 0) {
            if ($avoidFolder | Where-Object { $dirPath -like "*\$_\*" }) {
                return $false
            }
        }

        # Skip if file extension is not allowed
        if ($onlyFile.Count -gt 0 -and ($onlyFile -notcontains $ext)) {
            return $false
        }

        # Skip if file extension is blocked
        if ($avoidFile.Count -gt 0 -and ($avoidFile -contains $ext)) {
            return $false
        }

        return $true
    }

    Write-Output $files.Count
}
