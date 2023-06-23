param(
     [Parameter()]
     [string]$Package
 )

# Run in both system context and user context
pwsh.exe -MTA -Command "Start-Transcript -path C:\manualinstall.txt -append; Install-WinGetPackage -Id $($Package); Stop-Transcript"
# Add-Content -Path "C:\DevBoxCustomizations\runAsUser.ps1" -Value "Install-WinGetPackage -Id $($Package)"
