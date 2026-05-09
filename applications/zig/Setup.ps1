$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "Common.ps1")

Install-Package -Choco -Package zig

$Version = (zig version)
$File = "zls-x86_64-windows-$Version.zip"
$Url = "https://builds.zigtools.org/$File"
$DownloadDir = Join-Path $env:USERPROFILE "Downloads"
$ThirdPartyDir = Join-Path $env:USERPROFILE "ThirdParty"
$Dest = Join-Path $DownloadDir $File
$DirName = "zls-$Version"
$InstallDir = Join-Path $ThirdPartyDir $DirName
$Exe = Join-Path $InstallDir "zls.exe"

if (-not (Test-Path $Exe)) {
    Info -Message "Downloading 'ZLS (Zig Language Server) $Version' portable archive."
    New-Item -ItemType Directory -Force -Path $DownloadDir | Out-Null
    New-Item -ItemType Directory -Force -Path $ThirdPartyDir | Out-Null
    Invoke-WebRequest -Uri $Url -OutFile $Dest
    $ExtractedDir = Join-Path $DownloadDir $DirName
    New-Item -ItemType Directory -Force -Path $ExtractedDir | Out-Null
    Expand-Archive -Path $Dest -DestinationPath $ExtractedDir -Force
    if (Test-Path $InstallDir) {
        Remove-Item -Recurse -Force $InstallDir
    }
    Move-Item $ExtractedDir $ThirdPartyDir
    Remove-Item -Force $Dest
}

Add-ToUserPath -PathToAdd $InstallDir
