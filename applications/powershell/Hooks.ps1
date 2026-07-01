. (Join-Path $env:DOTFILES_ROOT "commons\Utils.ps1")

$global:LastDirEnvInvokedPath = ""

function Invoke-DirectoryEnvironment {
    param(
        [Parameter(Mandatory)]
        [string]$Path
    )

    if ($Path -ne $global:LastDirEnvInvokedPath) {
        $global:LastDirEnvInvokedPath = $Path
        $DirEnvFile = Join-Path $Path ".direnv.ps1"
        if (Test-Path $DirEnvFile) {
            Write-InfoLog -Message "Invoking `"$DirEnvFile`"."
            . Invoke-Script -Script $DirEnvFile
        }
    }
}

function Set-Location {
    Microsoft.PowerShell.Management\Set-Location @args
    Invoke-DirectoryEnvironment -Path $PWD.Path
}
