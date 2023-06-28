param (
    [Parameter()]
    [string]$CloneUri
)

cd C:\
git clone $CloneUri
