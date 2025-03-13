function working {
    # Set the fixed path for the working directory
    $workingDirectory = "C:\Users\User\PowerShell\custom-scripts\git-scripts\working"
    
    # Ensure the working directory exists
    if (!(Test-Path -Path $workingDirectory)) {
        New-Item -ItemType Directory -Path $workingDirectory | Out-Null
    }

    # Get the project name from the Git repository's root directory
    try {
        $projectName = (Get-Item (git rev-parse --show-toplevel 2>$null)).Name
    } catch {
        Write-Host "Not inside a git repository." -ForegroundColor Red
        return
    }

    # Define the path for the project-specific file inside the working directory
    $filePath = Join-Path -Path $workingDirectory -ChildPath "$projectName.txt"
    
    # Get the current branch name
    $branch = git rev-parse --abbrev-ref HEAD 2>&1
    if ($branch -match 'fatal') {
        Write-Host "Not inside a git repository." -ForegroundColor Red
        return
    }

    # Function to display saved branches
    function Show-Branches {
        if (Test-Path $filePath) {
            Write-Host "Working branches listed in ${projectName}:" -ForegroundColor Cyan
            $branches = Get-Content $filePath
            if ($branches.Count -eq 0) {
                Write-Host "No branches saved." -ForegroundColor DarkYellow
            } else {
                $branches | ForEach-Object -Begin { $i = 1 } -Process {
                    Write-Host "$i. $_" -ForegroundColor Yellow
                    $i++
                }
            }
        } else {
            Write-Host "No branches saved." -ForegroundColor DarkYellow
        }
    }

    # Function to add the current branch
    function Add-Branch {
        if (!(Test-Path -Path $filePath)) {
            New-Item -ItemType File -Path $filePath | Out-Null
        }

        if (!(Select-String -Path $filePath -Pattern "^$branch$" -Quiet)) {
            $branch | Out-File -FilePath $filePath -Append
            Write-Host "Working branch '$branch' added to $projectName." -ForegroundColor Green
        } else {
            Write-Host "Branch '$branch' is already in $projectName." -ForegroundColor Yellow
        }
    }

    # Function to remove the current branch
    function Remove-Branch {
        if (Test-Path $filePath) {
            $branches = Get-Content $filePath
            if ($branches -contains $branch) {
                $branches = $branches | Where-Object { $_ -ne $branch }
                $branches | Set-Content $filePath
                Write-Host "Working branch '$branch' removed from $projectName." -ForegroundColor Magenta

                if ($branches.Count -eq 0) {
                    Remove-Item $filePath
                    Write-Host "File ${projectName}.txt is empty and has been deleted." -ForegroundColor Red
                }
            } else {
                Write-Host "Branch '$branch' is not a working branch in $projectName." -ForegroundColor Red
            }
        } else {
            Write-Host "No file found for this project: $projectName." -ForegroundColor Red
        }
    }

    function View-Branches {
        if (Test-Path $filePath) {
            notepad $filePath
        } else {
            Write-Host "No file found for this project: $projectName." -ForegroundColor Red
        }
    }

    # Function to clear all branches for the current project
    function Clear-Branches {
        if (Test-Path $filePath) {
            Remove-Item $filePath
            Write-Host "All branches cleared for ${projectName}." -ForegroundColor Red
        } else {
            Write-Host "No branches to clear for ${projectName}." -ForegroundColor DarkYellow
        }
    }

     # Function to list all projects with saved branches
    function List-Projects {
        $projectFiles = Get-ChildItem -Path $workingDirectory -Filter "*.txt"
        if ($projectFiles.Count -eq 0) {
            Write-Host "No projects with saved branches." -ForegroundColor DarkYellow
        } else {
            Write-Host "Projects with saved branches:" -ForegroundColor Cyan
            foreach ($file in $projectFiles) {
                Write-Host "- $($file.BaseName)" -ForegroundColor Yellow
            }
        }
    }

    # Function to clear all branches for the current project
    function Clear-Branches {
        if (Test-Path $filePath) {
            Remove-Item $filePath
            Write-Host "All branches cleared for ${projectName}." -ForegroundColor Red
        } else {
            Write-Host "No branches to clear for ${projectName}." -ForegroundColor DarkYellow
        }
    }

    # Function to switch to a saved branch by branch number
function Switch-Branch {
    if (Test-Path $filePath) {
        $branches = Get-Content $filePath

        # Check if branch number was provided and is valid
        if ($args[0] -match '^\d+$') {
            $branchIndex = [int]$args[0] - 1

            # Validate if branch number exists in the list
            if ($branchIndex -ge 0 -and $branchIndex -lt $branches.Count) {
                $targetBranch = $branches[$branchIndex]
                Write-Host "Switching to branch '$targetBranch'..." -ForegroundColor Green
                git checkout $targetBranch
            } else {
                Write-Host "Invalid branch number." -ForegroundColor Red
            }
        } else {
            Write-Host "Please provide a valid branch number." -ForegroundColor Red
        }
    } else {
        Write-Host "No branches saved for this project." -ForegroundColor DarkYellow
    }
}

    # Function to display usage instructions
    function Show-Help {
        Write-Host "Usage: working [command]" -ForegroundColor Gray
        Write-Host "Commands:" -ForegroundColor Gray
        Write-Host "  add        - Add the current branch to the working branches list."
        Write-Host "  remove     - Remove the current branch from the working branches list."
        Write-Host "  clear      - Clear all saved branches for the current project."
        Write-Host "  list       - List all projects with saved branches."
        Write-Host "  switch [n] - Switch to a branch by its list number (from 'working' list)."
        Write-Host "  view       - View the project file"
        Write-Host "  help       - Show this help message."
    }

    # Check command options
    switch ($args[0]) {
        ""       { Show-Branches }
        "add"    { Add-Branch }
        "remove" { Remove-Branch }
        "clear"  { Clear-Branches }
        "list"   { List-Projects }
        "switch" { Switch-Branch $args[1] }
        "view"   { View-Branches }
        "help"   { Show-Help }
        default  { Show-Branches }
    }
}
