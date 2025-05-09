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
  --only-folder <list>    Only include folders by name (e.g., 'src', 'apps')
  --only-file <list>      Only include files by extension (e.g., 'ts', 'tsx')
  -Help                   Show this help message

Example:
  count-file --avoid-folder '.git','node_modules' --avoid-file 'js','jsx' --only-folder 'src','apps' --only-file 'ts','tsx'
"@
        return
    }

    $basePath = Get-Location
    $files = Get-ChildItem -Path $basePath -Recurse -File

    if ($onlyFolder.Count -gt 0) {
        $files = $files | Where-Object {
            $relativePath = $_.FullName.Substring($basePath.Path.Length)
            $onlyFolder -contains ($relativePath -split '[\\/]' | Where-Object { $_ })[0]
        }
    }

    if ($avoidFolder.Count -gt 0) {
        $files = $files | Where-Object {
            $relativePath = $_.FullName.Substring($basePath.Path.Length)
            -not ($avoidFolder | Where-Object { $relativePath -like "*$_*" })
        }
    }

    if ($onlyFile.Count -gt 0) {
        $files = $files | Where-Object {
            $onlyFile -contains $_.Extension.TrimStart('.')
        }
    }

    if ($avoidFile.Count -gt 0) {
        $files = $files | Where-Object {
            -not ($avoidFile -contains $_.Extension.TrimStart('.'))
        }
    }

    Write-Output $files.Count
}
