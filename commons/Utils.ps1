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
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Level,
        [Parameter(Mandatory)]
        [ConsoleColor]$Color,
        [Parameter(Mandatory)]
        [string[]]$Message
    )

    if (-not $Message -or $Message.Count -eq 0) { return }

    Write-Host "[" -NoNewline
    Write-Host "$Level" -ForegroundColor $Color -NoNewline
    Write-Host "] $($Message[0])"

    $Indent = " " * "[$Level] ".Length
    if ($Message.Count -le 1) { return }
    foreach ($Line in $Message[1..($Message.Count - 1)]) {
        Write-Host "$Indent$Line"
    }
}

function Error {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string[]]$Message,
        [switch]$Exit
    )
    Log -Level "ERROR" -Color Red -Message $Message
    if ($Exit) {
        exit 1
    }
}

function Info {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string[]]$Message
    )

    Log -Level "INFO" -Color Blue -Message $Message
}

function Warn {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string[]]$Message
    )

    Log -Level "WARN" -Color Yellow -Message $Message
}

function Source-Script {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Script
    )
    # `-PathType Leaf` ensures that the script is a file.
    if (Test-Path -Path $Script -PathType Leaf) {
        . $Script
    }
    else {
        Error -Message "Script '$Script' not found." -Exit
    }
}

function Add-ToUserPath {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$PathToAdd
    )
    $PathToAdd = [Environment]::ExpandEnvironmentVariables($PathToAdd)
    $PathToAdd = $PathToAdd.TrimEnd("\").ToLowerInvariant() # Normalizing the path.
    if (-not (Test-Path $PathToAdd)) {
        Warn -Message "Path '$PathToAdd' does not exist, skipping adding it to the PATH."
        return
    }

    $CurrentPath = [Environment]::GetEnvironmentVariable("PATH", "User")
    if ([string]::IsNullOrWhiteSpace($CurrentPath)) { $PathEntries = @() }
    else { $PathEntries = $CurrentPath -split ";" }
    $PathEntries = $PathEntries | ForEach-Object { $_.TrimEnd('\').ToLowerInvariant() } # Normalizing the PATH entries.

    if ($PathEntries -notcontains $PathToAdd) {
        Info -Message "Adding '$PathToAdd' to User PATH."
        $NewPath = @($PathEntries + $PathToAdd) -join ';'
        [Environment]::SetEnvironmentVariable("Path", $NewPath, "User")
    }

    if (($env:PATH -split ';') -notcontains $PathToAdd) {
        Info -Message "Adding '$PathToAdd' to Session PATH."
        $env:PATH += ";$PathToAdd"
    }
}

function Install-Package {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ParameterSetName = "Choco")]
        [switch]$Choco,
        [Parameter(Mandatory)]
        [string]$Package
    )

    switch ($PSCmdlet.ParameterSetName) {
        "Choco" { choco install $Package -y | Out-Null }
    }

    if ($?) { Info -Message "Successfully installed package '$Package'." }
    else { Error -Message "Failed to install package '$Package'." }
}

function Create-Directory {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Path
    )

    New-Item -ItemType Directory -Path $Path -Force | Out-Null
    if (-not $?) { Error -Message "Failed to create directory '$Path'." }
}

function Create-Symboliclink {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$Target,
        [Parameter(Mandatory)]
        [string]$Destination
    )

    New-Item -ItemType SymbolicLink -Path $Destination -Target $Target -Force | Out-Null
    if ($?) { Info -Message "Successfully created symlink", "from '$Destination'", "to '$Target'." }
    else { Error -Message "Failed to create symlink '$Destination' -> '$Target'." }
}

function Install-ModuleIfMissing {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$ModuleName,
        [version]$MinimumVersion = "0.0"
    )

    $Installed = Get-Module -ListAvailable -Name $ModuleName | Sort-Object Version -Descending | Select-Object -First 1
    if (-not $Installed -or $Installed.Version -lt $MinimumVersion) {
        Info -Message "Installing module '$ModuleName'..."
        Install-Module -Name $ModuleName -MinimumVersion $MinimumVersion -Scope CurrentUser -Force -AllowClobber
    }
    else {
        Info -Message "Module '$ModuleName' is already installed."
    }

    Import-Module $ModuleName -ErrorAction Stop
}