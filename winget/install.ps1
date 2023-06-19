param(
     [Parameter()]
     [string]$Package
 )

# Run in both system context and user context
pwsh.exe -MTA -Command "Install-WinGetPackage -Id $($Package)"
Add-Content -Path "C:\DevBoxCustomizations\runAsUser.ps1" -Value "Install-WinGetPackage -Id $($Package)"
