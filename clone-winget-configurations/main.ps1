$CopyDir = "C:\WinGetConfig"
New-Item -Path $CopyDir -ItemType Directory
Copy-Item "./system.yaml" -Destination $CopyDir
Copy-Item "./user.yaml" -Destination $CopyDir