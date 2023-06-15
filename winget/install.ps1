param(
     [Parameter()]
     [string]$Package
 )

# Run in both system context and user context
pwsh.exe -MTA -Command "Install-WinGetPackage -Id $($Package)"
echo "Install-WinGetPackage -Id $($Package)" > "C:\DevBoxCustomizations\wingetinstall$($Package).ps1"
