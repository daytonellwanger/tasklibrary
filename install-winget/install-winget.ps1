Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Scope AllUsers
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
Install-Module Microsoft.WinGet.Client -Scope AllUsers

echo "Repair-WinGetPackageManager" > "C:\DevBoxCustomizations\repairwinget.ps1"
