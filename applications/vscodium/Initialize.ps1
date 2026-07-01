$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "commons\Utils.ps1")

# TODO: Create utility function for this.
#       Then create a .psd1 file storing all the metadata used to call that function.
$Version = "1.116.02821"
$File = "VSCodium-win32-x64-$Version.zip"
$Url = "https://github.com/VSCodium/vscodium/releases/download/$Version/$File"
$DownloadDir = Join-Path $env:USERPROFILE "Downloads"
$ThirdPartyDir = Join-Path $env:USERPROFILE "ThirdParty"
$Dest = Join-Path $DownloadDir $File
$DirName = "vscodium-$Version"
$InstallDir = Join-Path $ThirdPartyDir $DirName
$Exe = Join-Path $InstallDir "VSCodium.exe"

if (-not (Test-Path $Exe)) {
    Write-InfoLog -Message "Downloading 'VSCodium $Version' portable archive."
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

$Target = (Join-Path $env:DOTFILES_ROOT "applications\vscodium\settings.json")
$Destination = (Join-Path $env:USERPROFILE "AppData\Roaming\VSCodium\User\settings.json")
New-SymbolicLink -Destination $Destination -Target $Target
