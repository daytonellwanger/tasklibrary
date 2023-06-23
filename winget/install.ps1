param(
     [Parameter()]
     [string]$Package
 )

# Run in both system context and user context
Start-Transcript -path C:\manualinstall.txt -append
pwsh.exe -MTA -Command "Install-WinGetPackage -Id $($Package)"
Stop-Transcript
# Add-Content -Path "C:\DevBoxCustomizations\runAsUser.ps1" -Value "Install-WinGetPackage -Id $($Package)"
