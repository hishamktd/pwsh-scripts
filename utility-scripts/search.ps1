function Search {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Name,                         # Name to search for
        [string]$Path = ".",                    # Search path (default to current directory)
        [switch]$C,                             # Enable case-sensitive search
        [switch]$F,                             # Enable full word matching
        [ValidateSet("File", "Folder", "Both")]
        [string]$Type = "Both"                  # Search type: File, Folder, or Both (default to Both)
    )

    # Set search pattern based on flags
    $namePattern = [Regex]::Escape($Name)
    if ($F) {
        $namePattern = "\b$namePattern\b"       # Full word boundary
    }

    # Case sensitivity flag for regex
    $regexOptions = if ($C) { 'None' } else { 'IgnoreCase' }

    # Get search results based on type
    switch ($Type) {
        "File" {
            $items = Get-ChildItem -Path $Path -File -Recurse | Where-Object { $_.Name -match [regex]::new($namePattern, $regexOptions) }
        }
        "Folder" {
            $items = Get-ChildItem -Path $Path -Directory -Recurse | Where-Object { $_.Name -match [regex]::new($namePattern, $regexOptions) }
        }
        "Both" {
            $items = Get-ChildItem -Path $Path -Recurse | Where-Object { $_.Name -match [regex]::new($namePattern, $regexOptions) }
        }
    }

    # Output results
    $items | ForEach-Object {
        $_.FullName
    }
}
