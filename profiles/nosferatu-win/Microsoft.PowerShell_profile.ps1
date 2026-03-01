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
)

$CurrentUserPath = [Environment]::GetEnvironmentVariable("PATH", "User")

function Prompt {
    $Esc = [char]27
    $Cyan = "$Esc[36m"
    $Yellow = "$Esc[33m"
    $Red = "$Esc[31m"
    $Green = "$Esc[32m"
    $Reset = "$Esc[0m"

    $UserHome = [Environment]::GetFolderPath("UserProfile")
    $CurrentPath = $PWD.Path.Replace($UserHome, "~")
    if ($CurrentPath -eq "~") {
        $CurrentPath = "~\"
    }

    $GitInfo = ""

    git rev-parse --is-inside-work-tree 2>$null | Out-Null
    if ($LASTEXITCODE -eq 0) {
        $Branch = git branch --show-current

        # Try to get configured upstream first
        $Upstream = git rev-parse --abbrev-ref --symbolic-full-name "@{u}" 2>$null
        if (-not $Upstream) {
            # Fallback: assume origin/<same-name> if it exists
            git show-ref --verify --quiet "refs/remotes/origin/$Branch"
            if ($LASTEXITCODE -eq 0) {
                $Upstream = "origin/$Branch"
            }
        }

        if (git status --porcelain 2>$null) {
            $GitInfo += "$Red*"
        }

        $GitInfo += "$Yellow$Branch$Reset $(git rev-parse --short HEAD)"

        if ($Upstream) {
            $AheadBehind = git rev-list --left-right --count "$Branch...$Upstream"
            $AheadCount, $BehindCount = $AheadBehind -split '\s+'

            if ($AheadCount -ne 0) {
                $GitInfo += " $Green+$AheadCount"
            }
            if ($BehindCount -ne 0) {
                $GitInfo += " $Red-$BehindCount"
            }
            $GitInfo += "$Reset"
        }

        $GitInfo = " ($GitInfo)"
    }

    return "$Cyan$CurrentPath$Reset$GitInfo`n> "
}

function Log {
    param (
        [Parameter(Mandatory)]
        [string]$Level,
        [Parameter(Mandatory)]
        [ConsoleColor]$Color,
        [Parameter(Mandatory)]
        [string]$Message
    )
    Write-Host "[" -NoNewline
    Write-Host "$Level" -ForegroundColor $Color -NoNewline
    Write-Host "] $Message"
}

function Error {
    param (
        [Parameter(Mandatory)]
        [string]$Message,
        [switch]$Exit
    )
    Log -Level "ERROR" -Color Red -Message $Message
    if ($Exit) {
        exit 1
    }
}

function Info {
    param (
        [Parameter(Mandatory)]
        [string]$Message
    )
    Log -Level "INFO" -Color Blue -Message $Message
}

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

# Set environment variables
[Environment]::SetEnvironmentVariable("PATH", $CurrentUserPath, "User")
[Environment]::SetEnvironmentVariable("JAVA_HOME", "$env:USERPROFILE\Thirdparty\openjdk-24.0.1\", "User")
[Environment]::SetEnvironmentVariable("GOPATH", "$env:USERPROFILE\Thirdparty\go-1.26.0\third-party\", "User")

# Aliases
Set-Alias ghc "ghc-9.8.2.exe"
Set-Alias gti git # For typos ;)
