$code = Invoke-RestMethod -Uri https://aka.ms/install-powershell.ps1
$null = New-Item -Path function:Install-PowerShell -Value $code
Install-PowerShell -UseMSI -Quiet
