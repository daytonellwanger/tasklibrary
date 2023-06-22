param(
    [Parameter()]
    [string]$ConfigurationFile,
    [Parameter()]
    [string]$DownloadUrl,
    [Parameter()]
    [string]$RunAsUser
 )

Start-Transcript -path C:\customizationlogs.txt -append

function SetupScheduledTasks {
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
    $Action.Path = "PowerShell.exe"
    $Action.Arguments = "pwsh.exe -MTA -Command C:\DevBoxCustomizations\runAsUser.ps1"

    $TaskFolder = $ShedService.GetFolder("\")
    $TaskFolder.RegisterTaskDefinition("Customizations", $Task , 6, "Users", $null, 4)
}

function InstallPS7 {
    $code = Invoke-RestMethod -Uri https://aka.ms/install-powershell.ps1
    $null = New-Item -Path function:Install-PowerShell -Value $code
    Install-PowerShell -UseMSI -Quiet
    # Need to update the path post install
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

function InstallWinGet {
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Scope AllUsers
    Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
    pwsh.exe -MTA -Command "Install-Module Microsoft.WinGet.Client -Scope AllUsers"
    pwsh.exe -MTA -Command "Install-Module Microsoft.WinGet.Configuration -AllowPrerelease -Scope AllUsers"
    pwsh.exe -MTA -Command "Repair-WinGetPackageManager -Latest"
    Add-Content -Path "C:\DevBoxCustomizations\runAsUser.ps1" -Value "Repair-WinGetPackageManager -Latest"
}

# TODO - only need to setup scheduled tasks if running as user
if (!(Test-Path -PathType Leaf "C:\DevBoxCustomizations\lockfile")) {
    SetupScheduledTasks
    InstallPS7
    InstallWinGet
}

if ($DownloadUrl) {
    $ConfigurationFileDir = Split-Path -Path $ConfigurationFile
    if(-Not (Test-Path -Path $ConfigurationFileDir))
    {
        New-Item -ItemType Directory -Path $ConfigurationFileDir
    }

    Invoke-WebRequest -Uri $DownloadUrl -OutFile $ConfigurationFile
}

if ($RunAsUser -eq "true") {
    Add-Content -Path "C:\DevBoxCustomizations\runAsUser.ps1" -Value "Get-WinGetConfiguration -File $($ConfigurationFile) | Invoke-WinGetConfiguration -AcceptConfigurationAgreements"
} else {
    pwsh.exe -MTA -Command "Get-WinGetConfiguration -File $($ConfigurationFile) | Invoke-WinGetConfiguration -AcceptConfigurationAgreements"
}

echo "Running pwsh.exe"
pwsh.exe -MTA -Command "Get-WinGetConfiguration -File $($ConfigurationFile) | Invoke-WinGetConfiguration -AcceptConfigurationAgreements"
echo "Done running pwsh.exe"

Stop-Transcript
