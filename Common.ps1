function Elevate {
    # Elevate powershell environment to Administrator Priviledges,
    # which is needed for creating Symbolic Links and Modifying PATH environment variable.
    # Reference: https://powershellcommands.com/powershell-elevate-to-admin-in-script
    if (-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
        exit
    }
}

function Log {
    param (
        [Parameter(Mandatory)]
        [string]$Level,
        [Parameter(Mandatory)]
        [ConsoleColor]$Color,
        [Parameter(Mandatory)]
        [string]$Message
    )
    Write-Host "[" -NoNewline
    Write-Host "$Level" -ForegroundColor $Color -NoNewline
    Write-Host "] $Message"
}

function Error {
    param (
        [Parameter(Mandatory)]
        [string]$Message,
        [switch]$Exit
    )
    Log -Level "ERROR" -Color Red -Message $Message
    if ($Exit) {
        exit 1
    }
}

function Info {
    param (
        [Parameter(Mandatory)]
        [string]$Message
    )
    Log -Level "INFO" -Color Blue -Message $Message
}

function Source-Script {
    param (
        [Parameter(Mandatory)]
        [string]$Script
    )
    # `-PathType Leaf` ensures that the script is a file.
    if (Test-Path -Path $Script -PathType Leaf) {
        . $Script
    } else {
        Error -Message "Script '$Script' not found." -Exit
    }
}

function Add-ToUserPath {
    param(
        [Parameter(Mandatory)]
        [string]$PathToAdd
    )    
    $CurrentPath = [Environment]::GetEnvironmentVariable("PATH", "User")
    $PathEntries = $CurrentPath -split ';'
    if ($PathEntries -notcontains $PathToAdd) {
        Info -Message "Adding '$PathToAdd' to Session PATH."
        $NewPath = ($CurrentPath.TrimEnd(';') + ";$PathToAdd").Trim(';')
        [Environment]::SetEnvironmentVariable("Path", $NewPath, "User")
        $env:PATH = "$env:PATH;$PathToAdd"
    }
}

function Install-Package {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ParameterSetName = "Choco")]
        [switch]$Choco,
        [Parameter(Mandatory)]
        [string]$Package
    )

    switch ($PSCmdlet.ParameterSetName) {
        "Choco" { choco install $Package -y | Out-Null }
    }

    if ($?) {
        Info -Message "Successfully installed package '$Package'."
    } else {
        Error -Message "Failed to install package '$Package'."
    }
}
