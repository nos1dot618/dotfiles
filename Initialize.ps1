Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$DOTFILES_ROOT = (Get-Location).Path
# In Windows this environment variable is renamed to DOTFILES_PROFILE from PROFILE,
# to not confuse it with $PROFILE environment variable which points to powershell profile directory.
$DOTFILES_PROFILE = (Join-Path $DOTFILES_ROOT "profiles\nosferatu-win")

# Set DOTFILES_ROOT AND PROFILE for the currently ongoing session.
$env:DOTFILES_ROOT = $DOTFILES_ROOT
$env:DOTFILES_PROFILE = $DOTFILES_PROFILE

[Environment]::SetEnvironmentVariable("DOTFILES_ROOT", $DOTFILES_ROOT, "User")
[Environment]::SetEnvironmentVariable("DOTFILES_PROFILE", $DOTFILES_PROFILE, "User")

$CustomModulesPath = (Join-Path  $env:DOTFILES_ROOT "applications\powershell\Modules")
$CurrentModulesPath = [Environment]::GetEnvironmentVariable("PSModulePath", "User")

if ($CurrentModulesPath -notlike "*$CustomModulesPath*") {
    $NewModulesPath = if ([string]::IsNullOrWhiteSpace($CurrentModulesPath)) { $CustomModulesPath }
    else { "$CurrentModulesPath;$CustomModulesPath" }
    [Environment]::SetEnvironmentVariable("PSModulePath", $NewModulesPath, "User")
}

if ($env:PSModulePath -notlike "*$CustomModulesPath*") {
    $env:PSModulePath += ";$CustomModulesPath"
}

git submodule update --init --recursive

. (Join-Path $env:DOTFILES_ROOT "Prelude.ps1")

. Invoke-ScriptFile -Path (Join-Path $env:DOTFILES_PROFILE "Initialize.ps1")
