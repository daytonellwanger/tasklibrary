if (!(Test-Path "C:\DevBoxCustomizations\lockfile")) {
    Unregister-ScheduledTask -TaskName Customizations -Confirm:$false
    Unregister-ScheduledTask -TaskName CustomizationsCleanup -Confirm:$false
}
