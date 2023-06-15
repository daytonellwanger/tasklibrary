Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
Install-Module Microsoft.WinGet.Client

echo "Repair-WinGetPackageManager" > "C:\DevBoxCustomizations\repairwinget.ps1"
