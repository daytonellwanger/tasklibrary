Remove-Item -Path "C:\DevBoxCustomizations\lockfile"
Set-ExecutionPolicy Bypass -Scope Process -Force
Get-ChildItem "C:\DevBoxCustomizations" | Where { $_.FullName.EndsWith(".ps1") -and $_.Name -ne "cleanupScheduledTasks.ps1" -and $_.Name -ne "runAsUser.ps1" } | ForEach-Object { & $_.FullName }