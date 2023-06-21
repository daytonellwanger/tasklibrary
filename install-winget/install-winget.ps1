Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Scope AllUsers
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
pwsh.exe -MTA -Command "Install-Module Microsoft.WinGet.Client -Scope AllUsers"
pwsh.exe -MTA -Command "Install-Module Microsoft.WinGet.Configuration -AllowPrerelease -Scope AllUsers"
pwsh.exe -MTA -Command "Repair-WinGetPackageManager -Latest"
Add-Content -Path "C:\DevBoxCustomizations\runAsUser.ps1" -Value "Repair-WinGetPackageManager -Latest"
