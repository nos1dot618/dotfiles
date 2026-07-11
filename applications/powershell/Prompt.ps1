function Prompt {
    $Esc = [char]27
    $Cyan = "$Esc[36m"
    $Yellow = "$Esc[33m"
    $Red = "$Esc[31m"
    $Green = "$Esc[32m"
    $Reset = "$Esc[0m"

    $UserHome = [Environment]::GetFolderPath("UserProfile")
    $CurrentPath = $PWD.Path.Replace($UserHome, "~")

	$TopLeftEdge = "$([char]0x250C)"
	$Line = "$([char]0x2500)"
	$BottomLeftEdge = "$([char]0x2514)"
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

        $GitInfo = "$Cyan$Line($Reset$GitInfo$Cyan)"
    }

    return "`n$Cyan$TopLeftEdge$Line[$Reset$CurrentPath$Cyan]$GitInfo$Cyan`n$BottomLeftEdge$Line#$Reset "
}
