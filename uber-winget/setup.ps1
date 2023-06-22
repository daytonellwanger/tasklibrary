param(
    [Parameter()]
    [string]$ConfigurationFile,
    [Parameter()]
    [string]$DownloadUrl,
    [Parameter()]
    [string]$RunAsUser
 )

# TODO - only need to setup scheduled tasks if running as user
if (!(Test-Path -PathType Leaf "C:\DevBoxCustomizations\lockfile")) {
    PowerShell.exe ./setupScheduledTasks.ps1
    PowerShell.exe ./installPS7.ps1
    PowerShell.exe ./installWinGet.ps1
}

PowerShell.exe ./main.ps1 -ConfigurationFile $ConfigurationFile -DownloadUrl $DownloadUrl -RunAsUser ($RunAsUser -eq "true")
