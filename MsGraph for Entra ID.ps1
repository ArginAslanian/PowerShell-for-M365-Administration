# Connect to Entra ID with User.Read.All scope
Connect-MgGraph -Scopes User.Read.All

# Verify Connection
Get-MgContext

# Disconnect from Entra ID
Disconnect-MgGraph

# List all users in the directory
Get-MgUser -All

# View a user's details
Get-MgUser -UserId "<user@domain.com>"

# View a user's object ID
(Get-MgUser -UserId "<user@domain.com>").Id

# Update a user's display name
Update-MgUser -UserId "<user@domain.com>" -DisplayName "Updated Display Name"

# Assign a user to a group
Add-MgGroupMember -GroupId "<group-id>" -DirectoryObjectId "<user-id>"

# Remove a user from a group
Remove-MgGroupMember -GroupId "<group-id>" -DirectoryObjectId "<user-id>"

# Check user's group memberships
Get-MgUserMemberOf -UserId "<user@domain.com>"

# Create a new user
New-MgUser -AccountEnabled $true -DisplayName "New User" -MailNickname "newuser" -UserPrincipalName "newuser@domain.com" -PasswordProfile @{Password = "InitialPassword123"; ForceChangePasswordNextSignIn = $true}

# Delete a user
Remove-MgUser -UserId "<user@domain.com>"

# Reset a user's password
Update-MgUser -UserId "<user@domain.com>" -PasswordProfile @{Password = "NewPassword123"; ForceChangePasswordNextSignIn = $true}

# Enable a user account
Update-MgUser -UserId "<user@domain.com>" -AccountEnabled $true

# Disable a user account
Update-MgUser -UserId "<user@domain.com>" -AccountEnabled $false

# Assign a role to a user
Add-MgDirectoryRoleMember -DirectoryRoleId "<role-id>" -DirectoryObjectId "<user-id>"

# Remove a role from a user
Remove-MgDirectoryRoleMember -DirectoryRoleId "<role-id>" -DirectoryObjectId "<user-id>"

# List all roles assigned to a user
Get-MgUserAppRoleAssignment -UserId "<user@domain.com>"

# Assign a license to a user
Add-MgUserLicense -UserId "<user@domain.com>" -LicenseIds @("<license-id>")

# Assign E5 license to a user
$license = New-Object -TypeName Microsoft.Graph.PowerShell.Models.MicrosoftGraphAssignedLicense
$license.SkuId = "<E5-license-sku-id>"
$addLicenses = New-Object -TypeName Microsoft.Graph.PowerShell.Models.MicrosoftGraphAssignedLicenses
$addLicenses.AddLicenses = @($license)  
Set-MgUserLicense -UserId "<user@domain.com>" -AddLicenses $addLicenses 

# Remove a license from a user
Remove-MgUserLicense -UserId "<user@domain.com>" -LicenseIds @("<license-id>")

# Create a new group
New-MgGroup -DisplayName "New Group" -MailEnabled $false -MailNickname "newgroup" -SecurityEnabled $true

# Delete a group
Remove-MgGroup -GroupId "<group-id>"

# List all groups in the directory
Get-MgGroup -All

# View a group's details
Get-MgGroup -GroupId "<group-id>"

# Get sign-in logs for a user
Get-MgAuditLogSignIn -Filter "userPrincipalName eq '<user@domain.com>'"

# Get sign-in logs for failed sign-ins
Get-MgAuditLogSignIn -Filter "status/errorCode ne 0"

# Get sign-in logs for a specific application
Get-MgAuditLogSignIn -Filter "appDisplayName eq 'My Application'"

# Get risky sign-ins
Get-MgAuditLogSignIn -Filter "riskDetail ne 'none'"

# Get sign-ins from a specific location
Get-MgAuditLogSignIn -Filter "location/city eq 'New York'"

# Get sign-in logs within a specific date range
$startDate = (Get-Date).AddDays(-7).ToString("o")   
$endDate = (Get-Date).ToString("o")
Get-MgAuditLogSignIn -Filter "createdDateTime ge $startDate and createdDateTime le $endDate"

# Get audit logs for a specific application
Get-MgAuditLogDirectoryAudit -Filter "targetResources/any(tr: trd eq 'My Application')"

# Get audit logs for a user management activities
Get-MgAuditLogDirectoryAudit -Filter "targetResources/any(tr: tre eq '<user@domain.com>')"

# Get all sign-in logs
Get-MgAuditLogSignIn -All

# Get audit logs for user management activities
Get-MgAuditLogDirectoryAudit -Filter "activityDisplayName eq 'Add user' or activityDisplayName eq 'Update user' or activityDisplayName eq 'Delete user'" -All

# Get all audit logs
Get-MgAuditLogDirectoryAudit -All

# Get statistics on sign-in activities
Get-MgReportRootSignInActivity -Period "D7"

# Get statistics on user activities
Get-MgReportRootUserActivity -Period "D7"

# Get statistics on application usage
Get-MgReportRootAppUsage -Period "D7"

# Third-party application management    
# List all enterprise applications
Get-MgServicePrincipal -All 

# View details of a specific enterprise application
Get-MgServicePrincipal -ServicePrincipalId "<application-id>"

# Assign a user to an enterprise application
New-MgServicePrincipalAppRoleAssignment -ServicePrincipalId "<application-id>" -PrincipalId "<user-id>" -AppRoleId "<app-role-id>"

#######################################################
# User Devices

# List all devices registered to a user
Get-MgUserRegisteredDevice -UserId "<user@domain.com>"

# View details of a specific device
Get-MgDevice -DeviceId "<device-id>"

# List all devices a user has used to sign in
Get-MgUserAuthenticationMethodDevice -UserId "<user@domain.com>"

# List what device a user is currently using
Get-MgUserAuthenticationMethodDevice -UserId "<user@domain.com>" | Where-Object { $_.IsCurrentDevice -eq $true }