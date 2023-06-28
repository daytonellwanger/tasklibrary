param (
    [Parameter()]
    [string]$CloneUri
)

$CustomizationScriptsDir = "C:\DevBoxCustomizations"
$RunAsUserScript = "runAsUser.ps1"

Add-Content -Path "$($CustomizationScriptsDir)\$($RunAsUserScript)" -Value "cd C:\"
Add-Content -Path "$($CustomizationScriptsDir)\$($RunAsUserScript)" -Value "git clone $($CloneUri)"
