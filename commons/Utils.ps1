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
        "Choco" { choco install $Package -y | Out-Null }
    }

    if ($?) { Write-InfoLog -Message "Successfully installed package `"$Package`"." }
    else { Write-ErrorLog -Message "Failed to install package `"$Package`"." }
}

function New-Directory {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Path
    )

    New-Item -ItemType Directory -Path $Path -Force | Out-Null
    if (-not $?) { Write-ErrorLog -Message "Failed to create directory `"$Path`"." }
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

    New-Item -ItemType SymbolicLink -Path $Destination -Target $Target -Force | Out-Null
    if ($?) { Write-InfoLog -Message @("Successfully created symlink", "from `"$Destination`"", "to `"$Target`".") }
    else { Write-ErrorLog -Message @("Failed to create symlink", "from `"$Destination`"", "to `"$Target`".") }
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
        Write-InfoLog -Message "Installing PowerShell module `"$Name`"..."
        Install-Module -Name $Name -MinimumVersion $MinimumVersion -Scope CurrentUser -Force -AllowClobber
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

@{
    "touch" = "Invoke-Touch"
}.GetEnumerator() | ForEach-Object {
    Set-Alias -Name $_.Key -Value $_.Value
}