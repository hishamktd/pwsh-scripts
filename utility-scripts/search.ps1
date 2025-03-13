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

    # Lazy load regex options only when needed
    if (-not $script:RegexOptions) {
        $script:RegexOptions = @{ "CaseSensitive" = 'None'; "IgnoreCase" = 'IgnoreCase' }
    }

    # Set search pattern based on flags
    $namePattern = [Regex]::Escape($Name)
    if ($F) {
        $namePattern = "\b$namePattern\b"       # Full word boundary
    }

    # Case sensitivity flag for regex
    $regexOptions = if ($C) { [System.Text.RegularExpressions.RegexOptions]::None } else { [System.Text.RegularExpressions.RegexOptions]::IgnoreCase }

    # Get search results based on type
    $items = switch ($Type) {
        "File"   { Get-ChildItem -Path $Path -File -Recurse }
        "Folder" { Get-ChildItem -Path $Path -Directory -Recurse }
        "Both"   { Get-ChildItem -Path $Path -Recurse }
    }

    # Apply filtering
    $items = $items | Where-Object { $_.Name -match [regex]::new($namePattern, $regexOptions) }
    
    # Output results
    $items | ForEach-Object { $_.FullName }
    
    # Remove this function after execution
    Remove-Item -Path Function:\Search -ErrorAction SilentlyContinue
}