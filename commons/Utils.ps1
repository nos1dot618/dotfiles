Import-Module "PSLogger"

function Elevate {
    # Elevate powershell environment to Administrator Priviledges,
    # which is needed for creating Symbolic Links and Modifying PATH environment variable.
    # Reference: https://powershellcommands.com/powershell-elevate-to-admin-in-script
    if (-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
        exit
    }
}

function Invoke-Script {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Script
    )
    # `-PathType Leaf` ensures that the script is a file.
    if (Test-Path -Path $Script -PathType Leaf) {
        . $Script
    }
    else {
        Write-ErrorLog -Message "Script `"$Script`" not found." -Exit
    }
}

function Add-ToUserPath {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$PathToAdd
    )
    $PathToAdd = [Environment]::ExpandEnvironmentVariables($PathToAdd)
    $PathToAdd = $PathToAdd.TrimEnd("\").ToLowerInvariant() # Normalizing the path.
    if (-not (Test-Path $PathToAdd)) {
        Write-WarnLog -Message "Path `"$PathToAdd`" does not exist, skipping adding it to the PATH."
        return
    }

    $CurrentPath = [Environment]::GetEnvironmentVariable("PATH", "User")
    if ([string]::IsNullOrWhiteSpace($CurrentPath)) { $PathEntries = @() }
    else { $PathEntries = $CurrentPath -split ";" }
    $PathEntries = $PathEntries | ForEach-Object { $_.TrimEnd('\').ToLowerInvariant() } # Normalizing the PATH entries.

    if ($PathEntries -notcontains $PathToAdd) {
        $NewPath = @($PathEntries + $PathToAdd) -join ';'
        [Environment]::SetEnvironmentVariable("Path", $NewPath, "User")
        Write-InfoLog -Message "Added `"$PathToAdd`" to User PATH."
    }

    if (($env:PATH -split ';') -notcontains $PathToAdd) {
        $env:PATH += ";$PathToAdd"
        Write-InfoLog -Message "Added `"$PathToAdd`" to Session PATH."
    }
}

function Install-Package {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ParameterSetName = "Choco")]
        [switch]$Choco,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Package
    )

    switch ($PSCmdlet.ParameterSetName) {
        "Choco" {
            $Output = choco list --lo -r -e $Package
            if ($Output) {
                Write-InfoLog -Message "Package `"$Package`" is already installed via Chocolatey."
                return
            }

            choco install $Package -y | Out-Null
            if ($?) { Write-SuccessLog -Message "Package `"$Package`" installed via Chocolatey." }
            else { Write-ErrorLog -Message "Failed to install package `"$Package`" via Chocolatey." }
        }
    }
}

function New-Directory {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Path
    )

    New-Item -ItemType Directory -Path $Path -Force | Out-Null
    if ($?) { Write-InfoLog -Message "Ensured directory `"$Path`" exists." }
    else { Write-ErrorLog -Message "Failed to create directory `"$Path`"." }
}

function New-SymbolicLink {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Target,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Destination
    )
    if (Test-Path -LiteralPath $Destination) {
        $Item = Get-Item -LiteralPath $Destination
        if (-not $Item.LinkType) {
            Write-WarnLog -Message "Path `"$Destination`" already exists and is not a symbolic link; removing it."
            Remove-Item -LiteralPath $Destination -Recurse -Force
        }
    }

    New-Item -ItemType SymbolicLink -Path $Destination -Target $Target -Force | Out-Null
    if ($?) { Write-InfoLog -Message @("Created symbolic link", "from `"$Destination`"", "to `"$Target`".") }
    else { Write-ErrorLog -Message @("Failed to create symbolic link", "from `"$Destination`"", "to `"$Target`".") }
}

function Install-ModuleIfMissing {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
        [version]$MinimumVersion = "0.0"
    )

    $Installed = Get-Module -ListAvailable -Name $Name | Sort-Object Version -Descending | Select-Object -First 1
    if (-not $Installed -or $Installed.Version -lt $MinimumVersion) {
        Write-InfoLog -Message "Installing powershell module `"$Name`"..."
        Install-Module -Name $Name -MinimumVersion $MinimumVersion -Scope CurrentUser -Force -AllowClobber
        if ($?) { Write-SuccessLog -Message "PowerShell module `"$Name`" installed." }
        else { Write-ErrorLog -Message "Failed to install powershell module `"$Name`"." }
    }
    else {
        Write-InfoLog -Message "PowerShell module `"$Name`" is already installed."
    }

    Import-Module $Name -ErrorAction Stop
}

function Invoke-Touch {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Filepath
    )
    if (Test-Path $Filepath) { (Get-Item $Filepath).LastWriteTime = Get-Date }
    else { New-Item -ItemType File -Path $Filepath | Out-Null }
}

function Install-PortableArchive {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$ManifestPath,
        [string]$Version
    )

    $Manifest = Import-PowerShellDataFile $ManifestPath

    if ($Version) {
        $Manifest.Version = $Version
    }

    $DownloadDir = Join-Path $env:USERPROFILE "Downloads"
    $ThirdPartyDir = Join-Path $env:USERPROFILE "ThirdParty"
    $Archive = $Manifest.ArchiveName.Replace("{VERSION}", $Manifest.Version)
    $Url = $Manifest.Url.Replace("{VERSION}", $Manifest.Version).Replace("{ARCHIVE_NAME}", $Archive)
    $InstallName = "$($Manifest.Name)-$($Manifest.Version)"
    $InstallDir = Join-Path $ThirdPartyDir $InstallName
    $Executable = Join-Path $InstallDir $Manifest.Executable
    $ExecutableDir = Split-Path $Executable -Parent
    $ArchivePath = Join-Path $DownloadDir $Archive
    $ExtractDir = Join-Path $DownloadDir $InstallName

    if (Test-Path -LiteralPath $Executable) {
        Add-ToUserPath -PathToAdd $ExecutableDir
        Write-InfoLog "Portable archive `"$($Manifest.Name)`" is already installed."
        return
    }

    New-Directory $DownloadDir
    New-Directory $ThirdPartyDir

    Write-InfoLog -Message "Downloading `"$($Manifest.Name) $($Manifest.Version)`"..."
    Invoke-WebRequest $Url -OutFile $ArchivePath

    if (Test-Path -LiteralPath $ExtractDir) {
        Write-WarnLog -Message @("Found directory `"$ExtractDir`";", "removing for extraction.")
        Remove-Item -LiteralPath $ExtractDir -Recurse -Force
    }
    # TODO: Add support for various archive types.
    Write-InfoLog -Message "Extracting `"ArchivePath`"..."
    Expand-Archive $ArchivePath $ExtractDir
    $Children = @(Get-ChildItem -LiteralPath $ExtractDir)

    if (Test-Path $InstallDir) {
        Write-WarnLog -Message @("Found directory `"$InstallDir`";", "removing for installation.")
        Remove-Item -LiteralPath $InstallDir -Recurse -Force
    }

    # Strips the extra directory usually packaged with ZIPs.
    if (($Children.Count -eq 1) -and ($Children[0].PSIsContainer)) {
        Move-Item $Children[0].FullName $InstallDir
        Remove-Item -LiteralPath $ExtractDir -Force
    }
    else {
        Move-Item $ExtractDir $InstallDir
    }

    Remove-Item $ArchivePath -Force

    Add-ToUserPath -PathToAdd $ExecutableDir
    Write-SuccessLog -Message "Portable archive `"$($Manifest.Name) $($Manifest.Version)`" installed."
}

function Install-PortableExecutable {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$ManifestPath,
        [string]$Version
    )

    $Manifest = Import-PowerShellDataFile $ManifestPath

    if ($Version) {
        $Manifest.Version = $Version
    }

    $DownloadDir = Join-Path $env:USERPROFILE "Downloads"
    $ThirdPartyDir = Join-Path $env:USERPROFILE "ThirdParty"
    $FileName = $Manifest.FileName.Replace("{VERSION}", $Manifest.Version)
    $Url = $Manifest.Url.Replace("{VERSION}", $Manifest.Version).Replace("{FILE_NAME}", $FileName)
    $InstallName = "$($Manifest.Name)-$($Manifest.Version)"
    $InstallDir = Join-Path $ThirdPartyDir $InstallName
    $Executable = Join-Path $InstallDir $FileName
    $ExecutableDir = Split-Path $Executable -Parent
    $DownloadPath = Join-Path $DownloadDir $FileName

    if (Test-Path -LiteralPath $Executable) {
        Add-ToUserPath -PathToAdd $ExecutableDir
        Write-InfoLog -Message "Portable executable `"$($Manifest.Name)`" is already installed."
        return
    }

    New-Directory $DownloadDir
    New-Directory $ThirdPartyDir
    New-Directory $InstallDir

    Write-InfoLog -Message "Downloading `"$($Manifest.Name) $($Manifest.Version)`"..."
    Invoke-WebRequest -Uri $Url -OutFile $DownloadPath

    Move-Item -LiteralPath $DownloadPath -Destination $Executable -Force

    Add-ToUserPath -PathToAdd $ExecutableDir
    Write-SuccessLog -Message "Portable executable `"$($Manifest.Name) $($Manifest.Version)`" installed."
}

@{
    "touch" = "Invoke-Touch"
}.GetEnumerator() | ForEach-Object {
    Set-Alias -Name $_.Key -Value $_.Value
}
