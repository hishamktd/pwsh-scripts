$hour = (Get-Date).Hour
$user = $env:USERNAME

if ($hour -lt 12) {
    $greeting = "🌅 Good Morning"
} elseif ($hour -lt 17) {
    $greeting = "🌞 Good Afternoon"
} else {
    $greeting = "🌙 Good Evening"
}

$currentDir = (Get-Location).Path
$cpu = Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name
$ram = [Math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 2)

Write-Host "✨ $greeting, $user 🚀" -ForegroundColor Cyan
Write-Host "📂 Location: " -NoNewline
Write-Host "$currentDir" -ForegroundColor Yellow
Write-Host ""
Write-Host "🧠 CPU: $cpu" -ForegroundColor Green
Write-Host "💾 RAM: ${ram} GB" -ForegroundColor Magenta
Write-Host ""

# Show Git branch if in a repo
function Get-GitBranch {
    $gitDir = git rev-parse --git-dir 2>$null
    if ($LASTEXITCODE -eq 0) {
        $branch = git rev-parse --abbrev-ref HEAD
        Write-Host "🌿 Git Branch: $branch" -ForegroundColor Blue
    }
}
Get-GitBranch

