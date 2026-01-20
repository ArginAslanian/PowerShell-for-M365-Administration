# Set execution policy (recommended: CurrentUser scope to avoid org-wide changes)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

#Install Microsoft Graph module if not already installed
if (-not (Get-Module -ListAvailable -Name Microsoft.Graph)) {
    Install-Module -Name Microsoft.Graph -Scope CurrentUser -Force
}

# Import the Microsoft Graph module
Import-Module Microsoft.Graph

# Connect to Microsoft Graph
Connect-MgGraph -Scopes "DeviceManagementApps.ReadWrite.All","DeviceManagementConfiguration.ReadWrite.All","DeviceManagementManagedDevices.ReadWrite.All","DeviceManagementRBAC.ReadWrite.All" -UserPrincipalName admin@xyz.com

#Install the Intune Management module if not already installed
if (-not (Get-Module -ListAvailable -Name Microsoft.Graph.Intune)) {
    Install-Module -Name Microsoft.Graph.Intune -Scope CurrentUser -Force
}

# Import the Intune Management module
Import-Module Microsoft.Graph.Intune

# Connect to Intune
Connect-MSGraph -UserPrincipalName admin@xyz.com

#Disconnect from Intune
Disconnect-MSGraph

#Get list of all Intune managed devices
Get-IntuneManagedDevice -All

#Get list of all Intune device configurations
Get-IntuneDeviceConfiguration -All

#Get list of all Intune device compliance policies
Get-IntuneDeviceCompliancePolicy -All

#Get list of all Intune apps
Get-IntuneMobileApp -All

#Get Hardware ID of a specific device for Autopilot with Windows Autopilot Info
Install-Script -Name Get-WindowsAutopilotInfo -Force
Get-WindowsAutopilotInfo -OutputFile "C:\AutopilotHWID.csv" 

#Import the Autopilot devices from the CSV file | Or submit the CSV file via Intune portal
Import-IntuneAutopilotDevice -CsvFilePath "C:\AutopilotHWID.csv"

#Wipe a specific Intune managed device
$device = Get-IntuneManagedDevice -Filter "deviceName eq 'DeviceName'"
Invoke-IntuneManagedDeviceWipe -ManagedDeviceId $device.Id -KeepEnrollmentData $false -KeepUserData $false

#Retire a specific Intune managed device
$device = Get-IntuneManagedDevice -Filter "deviceName eq 'DeviceName'"
Invoke-IntuneManagedDeviceRetire -ManagedDeviceId $device.Id

#Sync a specific Intune managed device
$device = Get-IntuneManagedDevice -Filter "deviceName eq 'DeviceName'"
Invoke-IntuneManagedDeviceSync -ManagedDeviceId $device.Id  

#Fresh Start a specific Intune managed device
$device = Get-IntuneManagedDevice -Filter "deviceName eq 'DeviceName'"
Invoke-IntuneManagedDeviceFreshStart -ManagedDeviceId $device.Id -KeepUserData $true    

#Fresh Start a specific Intune managed device without keeping user data
$device = Get-IntuneManagedDevice -Filter "deviceName eq 'DeviceName'"
Invoke-IntuneManagedDeviceFreshStart -ManagedDeviceId $device.Id -KeepUserData $false

#Restart a specific Intune managed device
$device = Get-IntuneManagedDevice -Filter "deviceName eq 'DeviceName'"
Invoke-IntuneManagedDeviceRestart -ManagedDeviceId $device.Id

#Shut down a specific Intune managed device
$device = Get-IntuneManagedDevice -Filter "deviceName eq 'DeviceName'"
Invoke-IntuneManagedDeviceShutdown -ManagedDeviceId $device.Id

#Sync Intune policies to all devices
Get-IntuneManagedDevice -All | ForEach-Object { Invoke-IntuneManagedDeviceSync -ManagedDeviceId $_.Id }

#Set Windows Update ring for all devices
$updateRing = Get-IntuneDeviceConfiguration -Filter "displayName eq 'Windows Update Ring Name'"
Get-IntuneManagedDevice -All | ForEach-Object { Set-IntuneManagedDeviceConfigurationAssignment -DeviceConfigurationId $updateRing.Id -Target @{deviceAndAppManagementAssignmentFilterType="allDevices"} }   