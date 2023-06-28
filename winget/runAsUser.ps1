$CustomizationScriptsDir = "C:\DevBoxCustomizations"
$LockFile = "lockfile"
$SetVariablesScript = "setVariables.ps1"
$RunAsUserScript = "runAsUser.ps1"
$CleanupScript = "cleanup.ps1"
$RunAsUserTask = "DevBoxCustomizations"
$CleanupTask = "DevBoxCustomizationsCleanup"

Remove-Item -Path "$($CustomizationScriptsDir)\$($LockFile)"
