# Example Usage
```
name: example
image: microsoftwindowsdesktop_windows-ent-cpc_win11-22h2-ent-cpc-m365
hostInformation: general_a_8c32gb256ssd_v1
setupTasks:
  - task: install-chocolatey
  - task: choco
    inputs:
      package: vscode
  - task: choco
    inputs:
      package: notepadplusplus
```
