$PersonalizationScriptsDir = "C:\DevBoxPersonalization"
$LockFile = "lockfile"
$RunAsUserScript = "runAsUser.ps1"
$CleanupScript = "cleanup.ps1"
$RunAsUserTask = "DevBoxPersonalization"
$CleanupTask = "DevBoxPersonalizationCleanup"

if (!(Test-Path "$($PersonalizationScriptsDir)\$($LockFile)")) {
    Unregister-ScheduledTask -TaskName $RunAsUserTask -Confirm:$false
    Unregister-ScheduledTask -TaskName $CleanupTask -Confirm:$false
    Remove-Item $PersonalizationScriptsDir -Force -Recurse
}
