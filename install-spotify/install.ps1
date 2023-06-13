$Trigger = New-ScheduledTaskTrigger -AtLogon
$Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "Set-ExecutionPolicy Bypass -Scope Process -Force; choco install spotify -y"
Register-ScheduledTask -TaskName "Customization" -Trigger $Trigger -Action $Action -RunLevel Highest -Force