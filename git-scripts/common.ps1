# Lazy Load Git Add Function
$LazyAddFunction = {
    function add {
        git add .
        Remove-Item Function:\add -ErrorAction SilentlyContinue
    }
    Set-Item Function:\add ${function:add}
    add @args
}
Set-Item Function:\add $LazyAddFunction

# Lazy Load Git Stash Function
$LazyStashFunction = {
    function stash {
        git stash -u
        Remove-Item Function:\stash -ErrorAction SilentlyContinue
    }
    Set-Item Function:\stash ${function:stash}
    stash @args
}
Set-Item Function:\stash $LazyStashFunction

# Lazy Load Git Stash Apply Function
$LazyApplyFunction = {
    function apply {
        git stash apply
        Remove-Item Function:\apply -ErrorAction SilentlyContinue
    }
    Set-Item Function:\apply ${function:apply}
    apply @args
}
Set-Item Function:\apply $LazyApplyFunction

# Lazy Load Git Differ Function
$LazyDifferFunction = {
    function differ {
        param (
            [string]$branch = "main" 
        )

        git diff $branch
        Remove-Item Function:\differ -ErrorAction SilentlyContinue
    }
    Set-Item Function:\differ ${function:differ}
    differ @args
}
Set-Item Function:\differ $LazyDifferFunction
