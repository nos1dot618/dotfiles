. (Join-Path $env:DOTFILES_ROOT "commons\Utils.ps1")

function Invoke-GitPush {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )

    foreach ($Remote in (git remote)) {
        Write-InfoLog -Message "Pushing to remote `"$Remote`"..."

        $Output = if ($Args.Count -eq 0) { git push $Remote HEAD 2>&1 } else { git push $Remote @Args 2>&1 }
        if ($LASTEXITCODE -ne 0) {
            Write-ErrorLog -Message $Output
        }
    }
}

function Invoke-GitPrune {
    [CmdletBinding()]
    param ()
    Write-InfoLog -Message "Removing stale remote-tracking branches..."
    git fetch --prune
    Write-InfoLog -Message "Expiring reflogs..."
    git reflog expire --expire=now --all
    Write-InfoLog -Message "Pruning unreachable objects..."
    git gc --prune=now --aggressive
}

function Invoke-GitGUI {
    [CmdletBinding()]
    param ()
    gitk --all
}

@{
    "gitp"     = "Invoke-GitPush"
    "gitpush"  = "Invoke-GitPush"
    "gitprune" = "Invoke-GitPrune"
    "gitg"     = "Invoke-GitGUI"
    "gitgui"   = "Invoke-GitGUI"
}.GetEnumerator() | ForEach-Object {
    Set-Alias -Name $_.Key -Value $_.Value
}
