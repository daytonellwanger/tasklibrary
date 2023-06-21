param(
     [Parameter()]
     [string]$DownloadUrl
 )

Invoke-WebRequest -Uri $DownloadUrl -OutFile C:\DevBoxCustomizations\winget.yaml

# Run in both system context and user context
pwsh.exe -MTA -Command "Get-WinGetConfiguration -File C:\DevBoxCustomizations\winget.yaml | Invoke-WinGetConfiguration -AcceptConfigurationAgreements"
Add-Content -Path "C:\DevBoxCustomizations\runAsUser.ps1" -Value "Get-WinGetConfiguration -File C:\DevBoxCustomizations\winget.yaml | Invoke-WinGetConfiguration -AcceptConfigurationAgreements"
