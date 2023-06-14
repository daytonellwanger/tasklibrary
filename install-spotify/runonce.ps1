Remove-Item -Path "C:\DevBoxCustomizations\lockfile"
Set-ExecutionPolicy Bypass -Scope Process -Force
$env:ChocolateyInstall="C:\ProgramData\chocoportable"
choco install spotify -y