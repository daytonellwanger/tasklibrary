. .\setVariables.ps1

if (!(Test-Path "$($CustomizationScriptsDir)\$($LockFile)")) {
    Unregister-ScheduledTask -TaskName $RunAsUserTask -Confirm:$false
    Unregister-ScheduledTask -TaskName $CleanupTask -Confirm:$false
    Remove-Item $CustomizationScriptsDir -Force -Recurse
}
