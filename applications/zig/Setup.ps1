$ErrorActionPreference = "Stop"

. (Join-Path $env:DOTFILES_ROOT "Common.ps1")

Install-Package -Choco -Package zig

Info -Message "Successfully setup 'Zig'."
