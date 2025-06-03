function show-tree {
    param(
        [string]$Path = ".",
        [string[]]$Exclude = @(),
        [int]$Indent = 0
    )

    $items = Get-ChildItem -Path $Path -Directory | Where-Object {
        $Exclude -notcontains $_.Name
    }

    foreach ($item in $items) {
        Write-Host (" " * $Indent + "└─ " + $item.Name)
        Show-Tree -Path $item.FullName -Exclude $Exclude -Indent ($Indent + 3)
    }
}