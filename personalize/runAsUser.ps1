$PersonalizationScriptsDir = "C:\DevBoxPersonalization"
$LockFile = "lockfile"
$RunAsUserScript = "runAsUser.ps1"
$CleanupScript = "cleanup.ps1"
$RunAsUserTask = "DevBoxPersonalization"
$CleanupTask = "DevBoxPersonalizationCleanup"

echo "Waiting on OneDrive initialization..."
Start-Sleep -Seconds 120
Remove-Item -Path "$($PersonalizationScriptsDir)\$($LockFile)"

$PersonalizationScript = "$([Environment]::GetFolderPath('MyDocuments'))\.devbox\setup.ps1"
if (Test-Path -Path $PersonalizationScript) {
    & $PersonalizationScript
}

$PersonalizationWinGet = "$([Environment]::GetFolderPath('MyDocuments'))\.devbox\winget.yaml"
if (Test-Path -Path $PersonalizationWinGet) {
    Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{CommandLine="C:\Program Files\PowerShell\7\pwsh.exe -MTA -Command `"Get-WinGetConfiguration -File $($PersonalizationWinGet) | Invoke-WinGetConfiguration -AcceptConfigurationAgreements`""}
}
