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