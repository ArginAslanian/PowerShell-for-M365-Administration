# Connect to Intune with DeviceManagementManagedDevices.ReadWrite.All scope
Connect-MgGraph -Scopes DeviceManagementManagedDevices.ReadWrite.All

# Verify Connection
Get-MgContext

# List all managed devices
Get-MgDeviceManagementManagedDevice -All

# Wipe a managed device
Invoke-MgDeviceManagementManagedDeviceWipe -ManagedDeviceId "<device-id>" -KeepEnrollmentData $true -KeepUserData $false

# Retire a managed device
Invoke-MgDeviceManagementManagedDeviceRetire -ManagedDeviceId "<device-id>"

# Sync a managed device
Invoke-MgDeviceManagementManagedDeviceSyncDevice -ManagedDeviceId "<device-id>"

# Fresh Start a managed device
Invoke-MgDeviceManagementManagedDeviceFreshStart -ManagedDeviceId "<device-id>"

# Rename a managed device
Update-MgDeviceManagementManagedDevice -ManagedDeviceId "<device-id>" -DeviceName "New Device Name"

# Restore a managed device
Invoke-MgDeviceManagementManagedDeviceRestoreCloudPc -ManagedDeviceId "<device-id>"

# Restart a managed device
Invoke-MgDeviceManagementManagedDeviceRestart -ManagedDeviceId "<device-id>"