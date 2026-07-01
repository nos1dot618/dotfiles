. (Join-Path $env:DOTFILES_ROOT "commons\Utils.ps1")

function Invoke-GitPush {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )

    foreach ($Remote in (git remote)) {
        Write-InfoLog -Message "Pushing to remote '$Remote'."

        if ($Args.Count -eq 0) { git push $Remote HEAD }
        else { git push $Remote @Args }
    }
}

function Invoke-GitPrune {
    Write-InfoLog -Message "Removing stale remote-tracking branches..."
    git fetch --prune
    Write-InfoLog -Message "Expiring reflogs..."
    git reflog expire --expire=now --all
    Write-InfoLog -Message "Pruning unreachable objects..."
    git gc --prune=now --aggressive
}

@{
    "gitp"     = "Invoke-GitPush"
    "gitpush"  = "Invoke-GitPush"
    "gitprune" = "Invoke-GitPrune"
}.GetEnumerator() | ForEach-Object {
    Set-Alias -Name $_.Key -Value $_.Value
}
