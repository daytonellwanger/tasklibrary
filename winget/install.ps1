param(
     [Parameter()]
     [string]$Package
 )

# Run in both system context and user context
# Invoke-WmiMethod -Class Win32_Process -Name Create -ArgumentList 'C:\Program Files\PowerShell\7\pwsh.exe -MTA -Command "Install-WinGetPackage -Id Notepad++.Notepad++ > C:\a2.txt"'

Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{CommandLine='C:\Program Files\PowerShell\7\pwsh.exe -MTA -Command "Install-WinGetPackage -Id Notepad++.Notepad++ > C:\a4.txt"'}



# Restart-Computer
# Add-Content -Path "C:\DevBoxCustomizations\runAsUser.ps1" -Value "Install-WinGetPackage -Id $($Package)"

Stop-Transcript
