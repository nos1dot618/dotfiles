. (Join-Path $env:DOTFILES_ROOT "commons\Utils.ps1")
. Source-Script (Join-Path $env:DOTFILES_ROOT "applications\powershell\Prompt.ps1")
. Source-Script (Join-Path $env:DOTFILES_ROOT "applications\powershell\Hooks.ps1")
. Source-Script (Join-Path $env:DOTFILES_ROOT "applications\git\Utils.ps1")

# Parsing %DOTFILES_PROFILE%\Paths.txt and updating PATH environment variable.
$PathsFile = Join-Path $env:DOTFILES_PROFILE "Paths.txt"
if (Test-Path $PathsFile) {
    Get-Content $PathsFile | ForEach-Object {
        $Path = $_.Trim()
        if ([string]::IsNullOrWhiteSpace($Path)) { continue }
        Add-ToUserPath -PathToAdd $Path
    }
}

# Parsing %DOTFILES_PROFILE%\Env.txt and setting environment variables.
$EnvFile = Join-Path $env:DOTFILES_PROFILE "Env.txt"
if (Test-Path $EnvFile) {
    Get-Content $EnvFile | ForEach-Object {
        $Line = $_.Trim()
        if ([string]::IsNullOrWhiteSpace($Line) -or $Line.StartsWith("#")) { continue }

        $Parts = $Line -split "=", 2
        if ($Parts.Count -ne 2) { continue }

        $Key = $Parts[0].Trim()
        $Value = [Environment]::ExpandEnvironmentVariables($Parts[1].Trim())

        Set-Item -Path "env:$Key" -Value $Value
        [Environment]::SetEnvironmentVariable($Key, $Value, "User")
    }
}

# Parsing %DOTFILES_PROFILE%\Aliases.txt and setting aliases.
$AliasesFile = Join-Path $env:DOTFILES_PROFILE "Aliases.txt"
if (Test-Path $AliasesFile) {
    Get-Content $AliasesFile | ForEach-Object {
        $Line = $_.Trim()
        if ([string]::IsNullOrWhiteSpace($Line) -or $Line.StartsWith("#")) { continue }

        $Parts = $Line -split "=", 2
        if ($Parts.Count -ne 2) { continue }

        $Alias = $Parts[0].Trim()
        $Command = $Parts[1].Trim()

        Set-Alias $Alias $Command
    }
}
