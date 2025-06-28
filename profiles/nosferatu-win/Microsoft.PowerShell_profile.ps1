$AddPaths = @(
    "$env:USERPROFILE\ThirdParty\emacs-30.1\bin"
    "$env:USERPROFILE\ThirdParty\focus"
    "$env:USERPROFILE\ThirdParty\openjdk-24.0.1_windows-x64_bin\jdk-24.0.1\bin"
)

$CurrentUserPath = [Environment]::GetEnvironmentVariable("PATH", "User")

foreach ($Path in $AddPaths) {
    if ($env:PATH -notlike "*$Path*") {
        Write-Host "INFO: Adding '$Path' to Session PATH"
        $env:PATH += ";$Path"
    }
    if ($CurrentUserPath -notlike "*$Path*") {
        Write-Host "INFO: Adding '$Path' to Persistent User PATH"
        $CurrentUserPath += ";$Path"
    }
}

# Set environment variables
[Environment]::SetEnvironmentVariable("PATH", $CurrentUserPath, "User")
[Environment]::SetEnvironmentVariable("JAVA_HOME", "$env:USERPROFILE\ThirdParty\openjdk-24.0.1_windows-x64_bin\jdk-24.0.1", "User")

# Aliases
Set-Alias ghc "ghc-9.8.2.exe"
