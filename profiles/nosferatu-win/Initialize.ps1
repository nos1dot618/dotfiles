$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "commons\Utils.ps1")

$ChocolateyPackagesPath = Join-Path $env:DOTFILES_PROFILE "ChocolateyPackages.txt"
foreach ($Package in Get-Content $ChocolateyPackagesPath) {
    $Package = $Package.Trim()
    if ([string]::IsNullOrWhiteSpace($Package) -or $Package.StartsWith("#")) { continue }
    Install-Package -Choco -Package $Package
}

$ApplicationsFile = Join-Path $env:DOTFILES_PROFILE "Applications.txt"
if (Test-Path $ApplicationsFile) {
    foreach ($Application in Get-Content $ApplicationsFile) {
        $Application = $Application.Trim()
        if ([string]::IsNullOrWhiteSpace($Application) -or $Application.StartsWith("#") ) { continue }
        . Source-Script -Script (Join-Path $env:DOTFILES_ROOT "applications\$Application\Initialize.ps1")
        Write-InfoLog -Message "Successfully installed application '$Application'."
    }
}

Write-InfoLog -Message "Successfully set up 'Nosferatu-Win' profile." 
