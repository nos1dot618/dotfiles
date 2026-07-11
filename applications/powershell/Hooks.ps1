. (Join-Path $env:DOTFILES_ROOT "Prelude.ps1")

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
            . Invoke-ScriptFile -Path $DirEnvFile
        }
    }
}

function Set-Location {
    Microsoft.PowerShell.Management\Set-Location @args
    Invoke-DirectoryEnvironment -Path $PWD.Path
}
