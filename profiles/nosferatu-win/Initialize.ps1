$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "Prelude.ps1")

$ChocolateyPackagesPath = Join-Path $env:DOTFILES_PROFILE "ChocolateyPackages.txt"
foreach ($Package in Get-Content $ChocolateyPackagesPath) {
    $Package = $Package.Trim()

    if ([string]::IsNullOrWhiteSpace($Package) -or $Package.StartsWith("#")) {
        continue
    }

    try {
        Install-ChocolateyPackage -Package $Package
    }
    catch {
        Write-ErrorLog -Message "Failed to install Chocolatey package `"$Package`"." -Err $_
    }
}

$ApplicationCatalogue = Import-PowerShellDataFile `
    -Path (Join-Path $env:DOTFILES_ROOT "applications\Catalogue.psd1") `
    -ErrorAction Stop

$ApplicationsFile = Join-Path $env:DOTFILES_PROFILE "Applications.txt"
if (Test-Path $ApplicationsFile) {
    foreach ($Application in Get-Content $ApplicationsFile) {
        $Application = $Application.Trim()

        if ([string]::IsNullOrWhiteSpace($Application) -or $Application.StartsWith("#") ) {
            continue
        }

        try {
            if ($ApplicationCatalogue.ContainsKey($Application)) {
                Install-PortableArchive -Catalogue $ApplicationCatalogue -ApplicationName $Application
                Write-SuccessLog -Message "Application `"$Application`" installed through catalogue."
            }
            else {
                . Invoke-ScriptFile -Path (Join-Path $env:DOTFILES_ROOT "applications\$Application\Initialize.ps1")
                Write-SuccessLog -Message "Application `"$Application`" installed."
            }
        }
        catch {
            Write-ErrorLog -Message "Failed to install application `"$Application`"." -Err $_
        }

    }
}

Write-SuccessLog -Message "Profile `"Nosferatu-Win`" set up."
