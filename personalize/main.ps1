$PersonalizationScriptsDir = "C:\DevBoxPersonalization"
$LockFile = "lockfile"
$RunAsUserScript = "runAsUser.ps1"
$CleanupScript = "cleanup.ps1"
$RunAsUserTask = "DevBoxPersonalization"
$CleanupTask = "DevBoxPersonalizationCleanup"

New-Item -Path $PersonalizationScriptsDir -ItemType Directory
New-Item -Path "$($PersonalizationScriptsDir)\$($LockFile)" -ItemType File
Copy-Item "./$($RunAsUserScript)" -Destination $PersonalizationScriptsDir
Copy-Item "./$($CleanupScript)" -Destination $PersonalizationScriptsDir

# Reference: https://learn.microsoft.com/en-us/windows/win32/taskschd/task-scheduler-objects
$ShedService = New-Object -comobject "Schedule.Service"
$ShedService.Connect()

# Schedule the cleanup script to run every minute as SYSTEM
$Task = $ShedService.NewTask(0)
$Task.RegistrationInfo.Description = "Dev Box Personalization Cleanup"
$Task.Settings.Enabled = $true
$Task.Settings.AllowDemandStart = $false

$Trigger = $Task.Triggers.Create(9)
$Trigger.Enabled = $true
$Trigger.Repetition.Interval="PT1M"

$Action = $Task.Actions.Create(0)
$Action.Path = "PowerShell.exe"
$Action.Arguments = "Set-ExecutionPolicy Bypass -Scope Process -Force; $($PersonalizationScriptsDir)\$($CleanupScript)"

$TaskFolder = $ShedService.GetFolder("\")
$TaskFolder.RegisterTaskDefinition("$($CleanupTask)", $Task , 6, "NT AUTHORITY\SYSTEM", $null, 5)

# Schedule the script to be run in the user context on login
$Task = $ShedService.NewTask(0)
$Task.RegistrationInfo.Description = "Dev Box Personalization"
$Task.Settings.Enabled = $true
$Task.Settings.AllowDemandStart = $false
$Task.Principal.RunLevel = 1

$Trigger = $Task.Triggers.Create(9)
$Trigger.Enabled = $true

$Action = $Task.Actions.Create(0)
$Action.Path = "PowerShell.exe"
$Action.Arguments = "Set-ExecutionPolicy Bypass -Scope Process -Force; $($PersonalizationScriptsDir)\$($RunAsUserScript)"

$TaskFolder = $ShedService.GetFolder("\")
$TaskFolder.RegisterTaskDefinition("$($RunAsUserTask)", $Task , 6, "Users", $null, 4)
