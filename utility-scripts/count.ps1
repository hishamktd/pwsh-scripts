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

    # Normalize all folder names to lower for comparison
    $avoidFolder = $avoidFolder | ForEach-Object { $_.ToLower() }
    $onlyFolder  = $onlyFolder  | ForEach-Object { $_.ToLower() }
    $avoidFile   = $avoidFile   | ForEach-Object { $_.ToLower() }
    $onlyFile    = $onlyFile    | ForEach-Object { $_.ToLower() }

    $files = $files | Where-Object {
        $fullPath = $_.FullName.ToLower()

        $folderOk = $true
        if ($avoidFolder.Count -gt 0) {
            $folderOk = -not ($avoidFolder | Where-Object { $fullPath -like "*\$_\*" })
        }
        if ($onlyFolder.Count -gt 0) {
            $folderOk = ($onlyFolder | Where-Object { $fullPath -like "*\$_\*" }) -ne $null
        }

        $ext = $_.Extension.TrimStart('.').ToLower()

        $fileExtOk = $true
        if ($avoidFile.Count -gt 0) {
            $fileExtOk = -not ($avoidFile -contains $ext)
        }
        if ($onlyFile.Count -gt 0) {
            $fileExtOk = ($onlyFile -contains $ext)
        }

        return $folderOk -and $fileExtOk
    }

    Write-Output $files.Count
}
