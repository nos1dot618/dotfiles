$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "commons\Utils.ps1")

$ChocolateyPackagesPath = Join-Path $env:DOTFILES_PROFILE "ChocolateyPackages.txt"
Get-Content $ChocolateyPackagesPath | ForEach-Object {
    $Package = $_.Trim()
    if ([string]::IsNullOrWhiteSpace($Package) -or $Package.StartsWith("#")) { continue }
    Install-Package -Choco -Package $Package
}

$ApplicationsFile = Join-Path $env:DOTFILES_PROFILE "Applications.txt"
if (Test-Path $ApplicationsFile) {
    Get-Content $ApplicationsFile | ForEach-Object {
        $Application = $_.Trim()
        if ([string]::IsNullOrWhiteSpace($Application) -or $Application.StartsWith("#") ) { return }
        . Source-Script -Script (Join-Path $env:DOTFILES_ROOT "applications\$Application\Setup.ps1")
        Info -Message "Successfully installed application '$Application'."
    }
}

Info -Message "Successfully set up 'Nosferatu-Win' profile." 
