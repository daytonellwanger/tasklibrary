Copy-Item "./runonce.ps1" -Destination "C:/"

$ShedService = New-Object -comobject 'Schedule.Service'
$ShedService.Connect()

$Task = $ShedService.NewTask(0)
$Task.RegistrationInfo.Description = 'Customizations'
$Task.Settings.Enabled = $true
$Task.Settings.AllowDemandStart = $false

$trigger = $task.triggers.Create(9)
$trigger.Enabled = $true

$action = $Task.Actions.Create(0)
$action.Path = 'PowerShell.exe'
$action.Arguments = 'C:\runonce.ps1'

$taskFolder = $ShedService.GetFolder("\")
$taskFolder.RegisterTaskDefinition('Customizations', $Task , 6, 'Users', $null, 4)