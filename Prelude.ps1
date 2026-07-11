$Modules = @(
    "PSLogger"
    "PSToolbox"
    "PSStoreFront"
)

foreach ($Module in $Modules) {
    if (-not (Get-Module -Name $Module)) {
        Import-Module $Module
    }
}

if (-not $global:LoadedScripts) {
    $global:LoadedScripts = [System.Collections.Generic.HashSet[string]]::new()
}

Get-ChildItem -Path (Join-Path $env:DOTFILES_ROOT "commons\powershell") -Filter *.ps1 | ForEach-Object {
    $Path = $_.FullName

    if ($global:LoadedScripts.Add($Path)) {
        . $Path
    }
}
