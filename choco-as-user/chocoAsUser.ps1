param(
     [Parameter()]
     [string]$Package
 )

echo "`$env:ChocolateyInstall='C:\ProgramData\chocoportable'; choco install $($Package) -y" > "C:\DevBoxCustomizations\chocoinstall$($Package).ps1"