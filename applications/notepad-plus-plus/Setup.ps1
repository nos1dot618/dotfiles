. (Join-Path $env:DOTFILES_ROOT "Common.ps1")

$Version = "8.9.4"
$File = "npp.$Version.portable.x64.zip"
$Url = "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v$Version/$File"
$DownloadDir = Join-Path $env:USERPROFILE "Downloads"
$ThirdPartyDir = Join-Path $env:USERPROFILE "ThirdParty"
$Dest = Join-Path $DownloadDir $File
$DirName = "notepad-plus-plus-$Version"
$InstallDir = Join-Path $ThirdPartyDir $DirName
$Exe = Join-Path $InstallDir "notepad++.exe"

if (-not (Test-Path $Exe)) {
    Info -Message "Downloading 'Notepad++ $Version' portable archive."
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
