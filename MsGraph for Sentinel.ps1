# Connect to Microsoft Graph for Defender with necessary scopes for Sentinel, Defender Alerts, Exchange Alerts, Defender for Endpoint, Defender for Identity, and Defender for Cloud Apps
Connect-MgGraph -Scopes "SecurityEvents.ReadWrite.All","SecurityAlerts.ReadWrite.All","SecurityIncident.ReadWrite.All","Device.ReadWrite.All","IdentityRiskEvent.ReadWrite.All","CloudAppSecurity.ReadWrite.All","Exchange.ManageAsApp"

# Verify Connection
Get-MgContext

# Disconnect from Microsoft Graph
Disconnect-MgGraph

# List all security alerts
Get-MgSecurityAlert -All

# View details of a specific security alert
Get-MgSecurityAlert -AlertId "<alert-id>"

# Update the status of a security alert
Update-MgSecurityAlert -AlertId "<alert-id>" -Status "Resolved"

# Assign a security alert to a user
Update-MgSecurityAlert -AlertId "<alert-id>" -AssignedTo "user@domain.com"

# Connect Entra ID to a Sentinel workspace
New-MgSecurityWorkspace -DisplayName "SentinelWorkspace" -TenantId "<tenant-id>" -SubscriptionId "<subscription-id>" -ResourceGroupName "<resource-group-name>"

# List all Sentinel workspaces
Get-MgSecurityWorkspace -All

# View details of a specific Sentinel workspace
Get-MgSecurityWorkspace -WorkspaceId "<workspace-id>"

# Delete a Sentinel workspace
Remove-MgSecurityWorkspace -WorkspaceId "<workspace-id>"

# Create a custom security alert rule
New-MgSecurityAlertRule -DisplayName "Custom Alert Rule" -Description "This is a custom alert rule for Sentinel." -Severity "High" -Enabled $true

# List all custom security alert rules
Get-MgSecurityAlertRule -All

# View details of a specific custom security alert rule
Get-MgSecurityAlertRule -AlertRuleId "<alert-rule-id>"

# Update a custom security alert rule
Update-MgSecurityAlertRule -AlertRuleId "<alert-rule-id>" -Severity "Medium"

#######################################################################################
# Sentinel integration with Microsoft Defender for Endpoint
# List all devices in Defender for Endpoint
Get-MgSecurityDevice -All

# View details of a specific device
Get-MgSecurityDevice -DeviceId "<device-id>"

# Isolate a device
Invoke-MgSecurityDeviceIsolate -DeviceId "<device-id>" -IsolationType "Full"

# Release a device from isolation
Invoke-MgSecurityDeviceRelease -DeviceId "<device-id>"

# Run a malware scan on a device
Invoke-MgSecurityDeviceRunMalwareScan -DeviceId "<device-id>" -ScanType "Quick" 
####################################################################################### 

# Sentinel integration with Microsoft Defender for Identity
# List all identities in Defender for Identity
Get-MgSecurityIdentity -All

# View details of a specific identity
Get-MgSecurityIdentity -IdentityId "<identity-id>"

# Investigate an identity
Invoke-MgSecurityIdentityInvestigate -IdentityId "<identity-id>"

# Block an identity
Invoke-MgSecurityIdentityBlock -IdentityId "<identity-id>"

# Unblock an identity
Invoke-MgSecurityIdentityUnblock -IdentityId "<identity-id>"

# List all incidents in Sentinel
Get-MgSecurityIncident -All

# View details of a specific incident
Get-MgSecurityIncident -IncidentId "<incident-id>"

# Update the status of an incident
Update-MgSecurityIncident -IncidentId "<incident-id>" -Status "Resolved"

# Assign an incident to a user
Update-MgSecurityIncident -IncidentId "<incident-id>" -AssignedTo "user@domain.com"

# Add an alert to an incident
Add-MgSecurityIncidentAlert -IncidentId "<incident-id>" -AlertId "<alert-id>"

#######################################################################################
# Sentinel integration with Microsoft Defender for Cloud Apps
# List all cloud app alerts
Get-MgSecurityCloudAppAlert -All

# View details of a specific cloud app alert
Get-MgSecurityCloudAppAlert -CloudAppAlertId "<cloud-app-alert-id>"

# Update the status of a cloud app alert
Update-MgSecurityCloudAppAlert -CloudAppAlertId "<cloud-app-alert-id>" -Status "Resolved"

# Assign a cloud app alert to a user
Update-MgSecurityCloudAppAlert -CloudAppAlertId "<cloud-app-alert-id>" -AssignedTo "user@domain.com"

# Create a new cloud app policy
New-MgSecurityCloudAppPolicy -DisplayName "New Cloud App Policy" -Description "This is a new cloud app policy." -PolicyType "Access"

# List all cloud app policies
Get-MgSecurityCloudAppPolicy -All

########################################################################################
# Sentinel integration with Microsoft Defender for Exchange Online
# List all email alerts
Get-MgSecurityEmailAlert -All

# View details of a specific email alert
Get-MgSecurityEmailAlert -EmailAlertId "<email-alert-id>"

# Update the status of an email alert
Update-MgSecurityEmailAlert -EmailAlertId "<email-alert-id>" -Status "Resolved"

# Assign an email alert to a user
Update-MgSecurityEmailAlert -EmailAlertId "<email-alert-id>" -AssignedTo "<user@domain.com>"

# Run a phishing simulation
Invoke-MgSecurityEmailAlertRunPhishingSimulation -EmailAlertId "<email-alert-id>"

########################################################################################