# Git add all
function add {
    git add .
}

# Git stash all
function stash {
    git stash -u
}

# Git stash apply
function apply {
    git stash apply
}

# Git pull main
function pull {
    git pull origin main --rebase
}

# Differ between branch 
# Default will be compare to main branch
# Can pass any branch as an argument to comare
function differ {
    param (
        [string]$branch = "main" 
    )

    git diff $branch
}