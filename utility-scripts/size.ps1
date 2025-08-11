function size {
    param(
        [Alias("p")]
        [string]$Path = "./",

        [Alias("u")]
        [ValidateSet("bytes", "kb", "mb", "gb", "tb")]
        [string]$Unit = "mb",

        [Alias("l")]
        [switch]$List
    )

    # Resolve path
    $ResolvedPath = Resolve-Path $Path -ErrorAction SilentlyContinue
    if (-not $ResolvedPath) {
        Write-Host "Path not found: $Path" -ForegroundColor Red
        return
    }

    if ($List) {
        # List direct children (non-recursive)
        $items = Get-ChildItem -Path $ResolvedPath -Force -ErrorAction SilentlyContinue

        $items | ForEach-Object {
            $sizeBytes = if ($_.PSIsContainer) {
                # Folder size (sum of its contents)
                (Get-ChildItem $_.FullName -Recurse -File -ErrorAction SilentlyContinue |
                 Measure-Object Length -Sum).Sum
            } else {
                $_.Length
            }

            switch ($Unit.ToLower()) {
                "bytes" { $size = $sizeBytes; $suffix = "Bytes" }
                "kb"    { $size = $sizeBytes / 1KB; $suffix = "KB" }
                "mb"    { $size = $sizeBytes / 1MB; $suffix = "MB" }
                "gb"    { $size = $sizeBytes / 1GB; $suffix = "GB" }
                "tb"    { $size = $sizeBytes / 1TB; $suffix = "TB" }
            }

            [PSCustomObject]@{
                Name     = $_.Name
                Type     = if ($_.PSIsContainer) { "Folder" } else { "File" }
                Size     = "{0:N2} $suffix" -f $size
            }
        } | Sort-Object Name | Format-Table -AutoSize

    } else {
        # Total size mode
        $TotalBytes = (Get-ChildItem -Path $ResolvedPath -Recurse -File -ErrorAction SilentlyContinue |
                       Measure-Object Length -Sum).Sum

        if (-not $TotalBytes) {
            Write-Host "No files found in path: $ResolvedPath"
            return
        }

        switch ($Unit.ToLower()) {
            "bytes" { $Result = $TotalBytes; $Suffix = "Bytes" }
            "kb"    { $Result = $TotalBytes / 1KB; $Suffix = "KB" }
            "mb"    { $Result = $TotalBytes / 1MB; $Suffix = "MB" }
            "gb"    { $Result = $TotalBytes / 1GB; $Suffix = "GB" }
            "tb"    { $Result = $TotalBytes / 1TB; $Suffix = "TB" }
        }

        "{0:N2} {1}" -f $Result, $Suffix
    }
}
