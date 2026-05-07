. (Join-Path $env:DOTFILES_ROOT "Common.ps1")
. Source-Script (Join-Path $env:DOTFILES_ROOT "applications\powershell\Prompt.ps1")

$AddPaths = @(
    "$env:USERPROFILE\Thirdparty\emacs-30.1\bin\"
    "$env:USERPROFILE\Thirdparty\focus\"
    "$env:USERPROFILE\Thirdparty\openjdk-24.0.1\bin\"
    "$env:USERPROFILE\Thirdparty\nasm-2.16.03\"
    "$env:USERPROFILE\Thirdparty\clion-2025.2\bin\"
    "$env:USERPROFILE\Thirdparty\idea-2025.1.3\bin\"
    "$env:USERPROFILE\Thirdparty\db-browser-for-sqlite-3.13.1\"
    "$env:USERPROFILE\Thirdparty\rclone-1.71.2\"
    "$env:USERPROFILE\Thirdparty\typst\"
    "$env:USERPROFILE\Thirdparty\microsoft-terminal\"
    "$env:USERPROFILE\Thirdparty\clion-2025.2\bin\mingw\bin\"
    "$env:USERPROFILE\Thirdparty\node-packages\node_modules\.bin\"
    "$env:USERPROFILE\Thirdparty\go-1.26.0\bin\"
    "$env:USERPROFILE\Thirdparty\go-1.26.0\third-party\bin\"
    "$env:USERPROFILE\Thirdparty\serve-d_0.7.6\"
)

$CurrentUserPath = [Environment]::GetEnvironmentVariable("PATH", "User")

foreach ($Path in $AddPaths) {
    if ($env:PATH -notlike "*$Path*") {
        Info -Message "Adding '$Path' to Session PATH."
        $env:PATH += ";$Path"
    }
    if ($CurrentUserPath -notlike "*$Path*") {
        Info -Message "Adding '$Path' to Persistent User PATH."
        $CurrentUserPath += ";$Path"
    }
}

# Set environment variables.
[Environment]::SetEnvironmentVariable("PATH", $CurrentUserPath, "User")
[Environment]::SetEnvironmentVariable("JAVA_HOME", "$env:USERPROFILE\Thirdparty\openjdk-24.0.1\", "User")
[Environment]::SetEnvironmentVariable("GOPATH", "$env:USERPROFILE\Thirdparty\go-1.26.0\third-party\", "User")

# Aliases.
Set-Alias ghc "ghc-9.8.2.exe"
Set-Alias gti git # For typos ;)
