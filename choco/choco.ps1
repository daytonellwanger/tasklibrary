param(
     [Parameter()]
     [string]$Package
 )

choco install $Package -y