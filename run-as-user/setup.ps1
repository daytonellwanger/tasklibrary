# Setup
if (!(Test-Path -PathType Container "C:\DevBoxCustomizations")) {
    New-Item -Path "C:\DevBoxCustomizations" -ItemType Directory
    New-Item -Path "C:\DevBoxCustomizations\lockfile" -ItemType File
    Copy-Item "./runAsUser.ps1" -Destination "C:\DevBoxCustomizations"
    Copy-Item "./cleanupScheduledTasks.ps1" -Destination "C:\DevBoxCustomizations"
}

# Reference: https://learn.microsoft.com/en-us/windows/win32/taskschd/task-scheduler-objects
$ShedService = New-Object -comobject "Schedule.Service"
$ShedService.Connect()

# Schedule the cleanup script to run every minute as the SYSTEM
$Task = $ShedService.NewTask(0)
$Task.RegistrationInfo.Description = "Customizations cleanup"
$Task.Settings.Enabled = $true
$Task.Settings.AllowDemandStart = $false

$Trigger = $Task.Triggers.Create(9)
$Trigger.Enabled = $true
$Trigger.Repetition.Interval="PT1M"

$Action = $Task.Actions.Create(0)
$Action.Path = "PowerShell.exe"
$Action.Arguments = "Set-ExecutionPolicy Bypass -Scope Process -Force; C:\DevBoxCustomizations\cleanupScheduledTasks.ps1"

$TaskFolder = $ShedService.GetFolder("\")
$TaskFolder.RegisterTaskDefinition("CustomizationsCleanup", $Task , 6, "NT AUTHORITY\SYSTEM", $null, 5)

# Schedule the script to be run in the user context on login
$Task = $ShedService.NewTask(0)
$Task.RegistrationInfo.Description = "Customizations"
$Task.Settings.Enabled = $true
$Task.Settings.AllowDemandStart = $false

$Trigger = $Task.Triggers.Create(9)
$Trigger.Enabled = $true

$Action = $Task.Actions.Create(0)
$Action.Path = "pwsh.exe"
$Action.Arguments = "C:\DevBoxCustomizations\runAsUser.ps1"

$TaskFolder = $ShedService.GetFolder("\")
$TaskFolder.RegisterTaskDefinition("Customizations", $Task , 6, "Users", $null, 4)
