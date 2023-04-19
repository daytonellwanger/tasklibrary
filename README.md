# Example Usage
```
name: example
image: /subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.DevCenter/devcenters/{devCenterName}/galleries/Default/images/microsoftwindowsdesktop_windows-ent-cpc_win11-22h2-ent-cpc-m365/versions/1.0.0@1.0.0
hostInformation: general_a_8c32gb256ssd_v1
supportsHibernation: false
setupTasks:
  - task: install-chocolatey
  - task: choco
    inputs:
      package: vscode
```
