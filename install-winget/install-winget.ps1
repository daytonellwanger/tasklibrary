Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
Install-Module Microsoft.WinGet.Client

echo "Repair-WinGetPackageManager" > "C:\DevBoxCustomizations\repairwinget.ps1"
