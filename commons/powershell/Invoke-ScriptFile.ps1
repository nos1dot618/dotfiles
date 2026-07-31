<#
.SYNOPSIS
Dot-sources a PowerShell script file.

.DESCRIPTION
Resolves the specified script path and dot-sources it into the current
scope.

This is useful for loading helper scripts, configuration files, or
module components while providing consistent logging and error handling.

Any errors encountered while locating or invoking the script are logged
and then rethrown to the caller.

.PARAMETER Path
The literal path to the PowerShell script to dot-source.

The path must refer to an existing file.

.EXAMPLE
Invoke-ScriptFile -Path ".\setup.ps1"

Dot-sources the setup.ps1 script into the current scope.

.EXAMPLE
Invoke-ScriptFile -Path "$PSScriptRoot\Private\Helpers.ps1"

Loads a helper script from the current module.

.EXAMPLE
Get-ChildItem "$PSScriptRoot\Private\*.ps1" | Invoke-ScriptFile

Dot-sources each script returned from the pipeline.

.NOTES
The script is dot-sourced rather than executed in a child scope, so any
functions, variables, aliases, or other definitions become available in
the current scope.

Any exceptions raised while locating or invoking the script are logged
and rethrown.
#>
function Invoke-ScriptFile {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory,
            ValueFromPipeline,
            ValueFromPipelineByPropertyName
        )]
        [Alias("FullName")]
        [ValidateNotNullOrEmpty()]
        [string]$Path
    )

    process {
        try {
            . (Get-Item -LiteralPath $Path -ErrorAction Stop).FullName
        }
        catch {
            Write-ErrorLog -Message "Failed to invoke script `"$Path`"." -Err $_
            throw
        }
    }
}
