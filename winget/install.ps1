param(
     [Parameter()]
     [string]$Package
 )

# Run in both system context and user context
Start-Transcript -path C:\manualinstall.txt -append
pwsh.exe -MTA -Command "Install-WinGetPackage -Id $($Package)" > C:\initialinstalltest.txt


pwsh.exe -Command 'pwsh.exe -MTA -Command "Install-WinGetPackage -Id Notepad++.Notepad++" > C:\a1.txt'

Invoke-WmiMethod -Class Win32_Process -Name Create -ArgumentList 'C:\Program Files\PowerShell\7\pwsh.exe -MTA -Command "Install-WinGetPackage -Id Notepad++.Notepad++ > C:\a2.txt"'

([WmiClass]'Win32_Process').Create('C:\Program Files\PowerShell\7\pwsh.exe -MTA -Command "Install-WinGetPackage -Id Notepad++.Notepad++ > C:\a3.txt')

Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{CommandLine='C:\Program Files\PowerShell\7\pwsh.exe -MTA -Command "Install-WinGetPackage -Id Notepad++.Notepad++ > C:\a4.txt"'}



# Restart-Computer
# Add-Content -Path "C:\DevBoxCustomizations\runAsUser.ps1" -Value "Install-WinGetPackage -Id $($Package)"

$Trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(2)
$Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "pwsh.exe -MTA -Command C:\DevBoxCustomizations\runassystem.ps1"
# Register-ScheduledTask -TaskName "CustomizationTest" -Trigger $Trigger -Action $Action -User System -RunLevel Highest -Force
Stop-Transcript
