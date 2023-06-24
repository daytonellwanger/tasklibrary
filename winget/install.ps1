param(
     [Parameter()]
     [string]$Package
 )

# Run in both system context and user context
Start-Transcript -path C:\manualinstall.txt -append
pwsh.exe -MTA -Command "Install-WinGetPackage -Id $($Package)" > C:\initialinstalltest.txt
Stop-Transcript

Start-Process pwsh.exe -ArgumentList "-MTA -Command `"Install-WinGetPackage -Id Notepad++.Notepad++ > C:\newprocesstest.txt`""
# Restart-Computer
# Add-Content -Path "C:\DevBoxCustomizations\runAsUser.ps1" -Value "Install-WinGetPackage -Id $($Package)"

$Trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(2)
$Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "pwsh.exe -MTA -Command C:\DevBoxCustomizations\runassystem.ps1"
Register-ScheduledTask -TaskName "CustomizationTest" -Trigger $Trigger -Action $Action -User System -RunLevel Highest -Force
