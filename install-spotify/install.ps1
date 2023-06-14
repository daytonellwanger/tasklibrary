# Setup
if (!(Test-Path -PathType Container "C:\DevBoxCustomizations")) {
    New-Item -Path "C:\DevBoxCustomizations" -ItemType Directory
    New-Item -Path "C:\DevBoxCustomizations\lockfile" -ItemType File
    Copy-Item "./runonce.ps1" -Destination "C:\DevBoxCustomizations"
    Copy-Item "./cleanup.ps1" -Destination "C:\DevBoxCustomizations"
}

# Schedule the cleanup script to run every minute
$Trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 1)
$Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "C:\DevBoxCustomizations\cleanup.ps1"
Register-ScheduledTask -TaskName "CustomizationsCleanup" -Trigger $Trigger -Action $Action -RunLevel Highest -Force

# Schedule the script to be run in the user context on login
# Reference: https://learn.microsoft.com/en-us/windows/win32/taskschd/task-scheduler-objects
$ShedService = New-Object -comobject "Schedule.Service"
$ShedService.Connect()

$Task = $ShedService.NewTask(0)
$Task.RegistrationInfo.Description = "Customizations"
$Task.Settings.Enabled = $true
$Task.Settings.AllowDemandStart = $false

$Trigger = $Task.Triggers.Create(9)
$Trigger.Enabled = $true

$Action = $Task.Actions.Create(0)
$Action.Path = "PowerShell.exe"
$Action.Arguments = "C:\DevBoxCustomizations\runonce.ps1"

$TaskFolder = $ShedService.GetFolder("\")
$TaskFolder.RegisterTaskDefinition("Customizations", $Task , 6, "Users", $null, 4)
