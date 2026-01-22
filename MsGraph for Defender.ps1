# Connect to Defender using Microsoft Graph with appropriate scopes
Connect-MgGraph -Scopes "Device.ReadWrite.All","ThreatIntelligence.ReadWrite.All"

# Verify Connection
Get-MgContext

# Disconnect from Defender
Disconnect-MgGraph

# List all devices in Defender
Get-MgDeviceManagementManagedDevice -All

# View a device's details
Get-MgDeviceManagementManagedDevice -ManagedDeviceId "<device-id>"

# Wipe a device
Invoke-MgDeviceManagementManagedDeviceWipe -ManagedDeviceId "<device-id>" -KeepEnrollmentData $true -KeepUserData $false

# Retire a device
Invoke-MgDeviceManagementManagedDeviceRetire -ManagedDeviceId "<device-id>"

# Initiate a scan on a device
Invoke-MgDeviceManagementManagedDeviceInitiateScan -ManagedDeviceId "<device-id>" -ScanType "full"

# Run a scan on a device for malware
Invoke-MgDeviceManagementManagedDeviceInitiateScan -ManagedDeviceId "<device-id>" -ScanType "malware"

# Run a custom scan on a device
Invoke-MgDeviceManagementManagedDeviceInitiateScan -ManagedDeviceId "<device-id>" -ScanType "custom" -CustomScanArguments @{"filePaths" = @("C:\Path\To\Scan")} 

# Get device malware state
Get-MgDeviceManagementManagedDeviceMalwareState -ManagedDeviceId "<device-id>"

# Get device security posture
Get-MgDeviceManagementManagedDeviceSecurityPosture -ManagedDeviceId "<device-id>"

# Get device compliance status
Get-MgDeviceManagementManagedDeviceComplianceStatus -ManagedDeviceId "<device-id>"

# Start a quick scan on a device
Invoke-MgDeviceManagementManagedDeviceInitiateScan -ManagedDeviceId "<device-id>" -ScanType "quick"

# Install security updates on a device
Invoke-MgDeviceManagementManagedDeviceInstallSecurityUpdates -ManagedDeviceId "<device-id>"

# Restart a device
Invoke-MgDeviceManagementManagedDeviceRestart -ManagedDeviceId "<device-id>"

# Shut down a device
Invoke-MgDeviceManagementManagedDeviceShutDown -ManagedDeviceId "<device-id>"

# Sync device
Invoke-MgDeviceManagementManagedDeviceSyncDevice -ManagedDeviceId "<device-id>"

# Locate a device
Invoke-MgDeviceManagementManagedDeviceLocateDevice -ManagedDeviceId "<device-id>"

# Quarantine a device
Invoke-MgDeviceManagementManagedDeviceQuarantine -ManagedDeviceId "<device-id>"

# Release a device from quarantine
Invoke-MgDeviceManagementManagedDeviceRelease -ManagedDeviceId "<device-id>"

# List all security alerts
Get-MgSecurityAlert -All

# View a security alert's details
Get-MgSecurityAlert -SecurityAlertId "<alert-id>"

# Run an investigation on a security alert
Invoke-MgSecurityAlertRunInvestigation -SecurityAlertId "<alert-id>"

# Run a remediation on a security alert
Invoke-MgSecurityAlertRunRemediation -SecurityAlertId "<alert-id>"

# Close a security alert
Update-MgSecurityAlert -SecurityAlertId "<alert-id>" -Status "closed"

# Run a threat hunt query
Invoke-MgThreatHuntingRunQuery -Query "<KQL-query-string>"

# View threat hunt results
Get-MgThreatHuntingGetResults -RunId "<run-id>"

# View threat hunts
Get-MgThreatHunting -All

# View a threat hunt's details
Get-MgThreatHunting -ThreatHuntingId "<threat-hunting-id>"

# Get threat intelligence indicators
Get-MgThreatIntelligenceIndicator -All

# Create a new threat intelligence indicator
New-MgThreatIntelligenceIndicator -IndicatorType "fileHash" -Value "<indicator-value>" -Description "New Threat Indicator" -Action "alert"  

# Update a threat intelligence indicator
Update-MgThreatIntelligenceIndicator -ThreatIntelligenceIndicatorId "<indicator-id>" -Description "Updated Description"

# Delete a threat intelligence indicator
Remove-MgThreatIntelligenceIndicator -ThreatIntelligenceIndicatorId "<indicator-id>"

# Assign a threat intelligence indicator to a device
Add-MgDeviceManagementManagedDeviceThreatIntelligenceIndicator -ManagedDeviceId "<device-id>" -ThreatIntelligenceIndicatorId "<indicator-id>"

# Remove a threat intelligence indicator from a device
Remove-MgDeviceManagementManagedDeviceThreatIntelligenceIndicator -ManagedDeviceId "<device-id>" -ThreatIntelligenceIndicatorId "<indicator-id>"

# List all threat intelligence indicators assigned to a device
Get-MgDeviceManagementManagedDeviceThreatIntelligenceIndicator -ManagedDeviceId "<device-id>"

# Generate a report of device compliance
Get-MgDeviceManagementDeviceCompliancePolicyDeviceStatus -PolicyId "<policy-id>" -All   

# Create a new device compliance policy
New-MgDeviceManagementDeviceCompliancePolicy -DisplayName "New Compliance Policy" -Description "Policy Description" -Platform "windows10AndLater" -Settings @{}     

