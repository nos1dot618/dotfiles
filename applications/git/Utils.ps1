. (Join-Path $env:DOTFILES_ROOT "commons\Utils.ps1")

function Git-Push {
    param(
        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Args
    )

    foreach ($Remote in (git remote)) {
        Info -Message "Pushing to remote '$Remote'."

        if ($Args.Count -eq 0) { git push $Remote HEAD }
        else { git push $Remote @Args }
    }
}
