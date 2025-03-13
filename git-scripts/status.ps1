function status {
    # Output the status header
    Write-Output "`e[1;34m==== Git Status ====`e[0m"
    git status -s | Out-String | Write-Output

    # Unstaged changes count
    $unstagedCount = git diff --stat | Select-String -Pattern '\| (\d+)' | Measure-Object | Select-Object -ExpandProperty Count
    Write-Output "`n`e[1;34m==== Unstaged Changes (Diff) ====`e[0m"
    git diff --color | Out-Host -Paging
    Write-Output "`e[1;34mUnstaged Changes - $unstagedCount files`e[0m"

    # Staged changes count
    $stagedCount = git diff --cached --stat | Select-String -Pattern '\| (\d+)' | Measure-Object | Select-Object -ExpandProperty Count
    Write-Output "`n`e[1;34m==== Staged Changes (Diff) ====`e[0m"
    git diff --cached --color | Out-Host -Paging
    Write-Output "`e[1;34mStaged Changes - $stagedCount files`e[0m"

    # Branch and remote status with styled alignment
    Write-Output "`n`e[1;34m==== Branch and Remote Status ====`e[0m"
    
    git branch -v | ForEach-Object {
        if ($_ -match '^\*') {
            # Current branch styled in yellow and aligned with tabs for readability
            $_ -replace '^\* (\S+)', "`e[1;33m* $1 `e[0m"
        }
        elseif ($_ -match 'origin/') {
            # Remote branches in magenta
            $_ -replace '(origin/\S+)', "`e[35m$1`e[0m"
        }
        else {
            # Local branches in cyan
            $_ -replace '^\s+(\S+)', "`e[36m$1`e[0m"
        }
    } | Out-String | Write-Output

    # Get ahead/behind count for the current branch relative to 'main'
    $aheadBehind = git rev-list --left-right --count main...HEAD
    $aheadCount, $behindCount = $aheadBehind -split "`t"
    Write-Output "`e[1;34mCurrent branch ahead by $aheadCount commits and behind by $behindCount commits from 'main'.`e[0m"

    git remote -v | Out-String | Write-Output

    # Closing separator line
    Write-Output "`e[1;34m=======================`e[0m"
}
