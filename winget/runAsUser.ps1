$CustomizationScriptsDir = "C:\DevBoxCustomizations"
$LockFile = "lockfile"
$SetVariablesScript = "setVariables.ps1"
$RunAsUserScript = "runAsUser.ps1"
$CleanupScript = "cleanup.ps1"
$RunAsUserTask = "DevBoxCustomizations"
$CleanupTask = "DevBoxCustomizationsCleanup"

echo "Waiting on OneDrive initialization..."
Start-Sleep -Seconds 120
Remove-Item -Path "$($CustomizationScriptsDir)\$($LockFile)"

$PersonalizationScript = "$([Environment]::GetFolderPath('MyDocuments'))\.devbox\setup.ps1"
if (Test-Path -Path $PersonalizationScript) {
    & $PersonalizationScript
}

$PersonalizationWinGet = "$([Environment]::GetFolderPath('MyDocuments'))\.devbox\winget.yaml"
if (Test-Path -Path $PersonalizationWinGet) {
    Get-WinGetConfiguration -File $PersonalizationWinGet | Invoke-WinGetConfiguration -AcceptConfigurationAgreements
}
