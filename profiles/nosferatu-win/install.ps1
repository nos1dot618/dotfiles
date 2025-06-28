# This must be executed with Adminstrator Priviledges
$ErrorActionPreference = "Stop"

# Install apps usig chocolatey package manager
$ChocolateyPackagesFile = (Join-Path $env:DOTFILES_PROFILE "chocolatey_packages.list")
Get-Content $ChocolateyPackagesFile | ForEach-Object {
    $PackageName = $_.Trim()
    if (-not [string]::IsNullOrWhiteSpace($PackageName)) {
        choco install $PackageName -y
    }
}
