param(
    [Parameter()]
    [string]$ConfigurationFile,
    [Parameter()]
    [string]$DownloadUrl,
    [Parameter()]
    [bool]$RunAsUser
 )

if ($DownloadUrl) {
    $ConfigurationFileDir = Split-Path -Path $ConfigurationFile
    if(-Not (Test-Path -Path $ConfigurationFileDir))
    {
        New-Item -ItemType Directory -Path $ConfigurationFileDir
    }

    Invoke-WebRequest -Uri $DownloadUrl -OutFile $ConfigurationFile
}

if ($RunAsUser) {
    Add-Content -Path "C:\DevBoxCustomizations\runAsUser.ps1" -Value "Get-WinGetConfiguration -File $($ConfigurationFile) | Invoke-WinGetConfiguration -AcceptConfigurationAgreements"
} else {
    pwsh.exe -MTA -Command "Get-WinGetConfiguration -File $($ConfigurationFile) | Invoke-WinGetConfiguration -AcceptConfigurationAgreements"
}
