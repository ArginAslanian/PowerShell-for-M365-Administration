# Set execution policy (recommended: CurrentUser scope to avoid org-wide changes)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

#Install the Entra ID Management module if not already installed
if (-not (Get-Module -ListAvailable -Name AzureAD)) {
    Install-Module -Name AzureAD -Scope CurrentUser -Force
}

# Import the Entra ID Management module
Import-Module AzureAD

# Connect to Entra ID
Connect-AzureAD -UserPrincipalName admin@xyz.com

#Disconnect from Entra ID
Disconnect-AzureAD

#Get list of all users
Get-AzureADUser -All $true

#Get list of all groups
Get-AzureADGroup -All $true

#Get list of all devices
Get-AzureADDevice -All $true

#Add a new user
New-AzureADUser -DisplayName "John Doe" -PasswordProfile (New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile -Property @{Password="P@ssw0rd"; ForceChangePasswordNextLogin=$true}) -UserPrincipalName "john.doe@xyz.com" -AccountEnabled $true

#Remove a user
Remove-AzureADUser -ObjectId (Get-AzureADUser -ObjectId "UserPrincipalName").ObjectId

#Update a user's display name
Set-AzureADUser -ObjectId (Get-AzureADUser -ObjectId "UserPrincipalName").ObjectId -DisplayName "Jane Doe"

#Reset a user's password
Set-AzureADUserPassword -ObjectId (Get-AzureADUser -ObjectId "UserPrincipalName").ObjectId -Password "NewP@ssw0rd" -ForceChangePasswordNextLogin $true

#Set a user location
Set-AzureADUser -ObjectId (Get-AzureADUser -ObjectId "UserPrincipalName").ObjectId -UsageLocation "US"

#Add user to a group
$group = Get-AzureADGroup -SearchString "GroupName"
Add-AzureADGroupMember -ObjectId $group.ObjectId -RefObjectId (Get-AzureADUser -ObjectId "UserPrincipalName").ObjectId

#Add user to multiple groups
$groups = @("GroupName1", "GroupName2", "GroupName3")
foreach ($groupName in $groups) {
    $group = Get-AzureADGroup -SearchString $groupName
    Add-AzureADGroupMember -ObjectId $group.ObjectId -RefObjectId (Get-AzureADUser -ObjectId "UserPrincipalName").ObjectId
}

#Assign license to a user - E5 License
$license = Get-AzureADSubscribedSku | Where-Object {$_.SkuPartNumber -eq "ENTERPRISEPREMIUM"}
Set-AzureADUserLicense -ObjectId (Get-AzureADUser -ObjectId "UserPrincipalName").ObjectId -AssignedLicenses @{AddLicenses=$license.SkuId; RemoveLicenses=@()}   

#Remove license from a user
$license = Get-AzureADSubscribedSku | Where-Object {$_.SkuPartNumber -eq "ENTERPRISEPREMIUM"}
Set-AzureADUserLicense -ObjectId (Get-AzureADUser -ObjectId "UserPrincipalName").ObjectId -AssignedLicenses @{AddLicenses=@(); RemoveLicenses=$license.SkuId}

#Remove user from a group
$group = Get-AzureADGroup -SearchString "GroupName"

#Lock a user account
Set-AzureADUser -ObjectId (Get-AzureADUser -ObjectId "UserPrincipalName").ObjectId -AccountEnabled $false

#Unlock a user account
Set-AzureADUser -ObjectId (Get-AzureADUser -ObjectId "UserPrincipalName").ObjectId -AccountEnabled $true

#Enable a user account
Set-AzureADUser -ObjectId (Get-AzureADUser -ObjectId "UserPrincipalName").ObjectId -AccountEnabled $true

#Disable a user account
Set-AzureADUser -ObjectId (Get-AzureADUser -ObjectId "UserPrincipalName").ObjectId -AccountEnabled $false

#Check if user account is locked
(Get-AzureADUser -ObjectId "UserPrincipalName").AccountEnabled

#Check if user account is disabled
(Get-AzureADUser -ObjectId "UserPrincipalName").AccountEnabled

#Get information about a specific user
Get-AzureADUser -Identity "UserPrincipalName"

#Get security information about a specific user
Get-AzureADUserSecurityInfo -ObjectId (Get-AzureADUser -ObjectId "UserPrincipalName").ObjectId

#Get password policies for a specific user
Get-AzureADUserPasswordPolicies -ObjectId (Get-AzureADUser -ObjectId "UserPrincipalName").ObjectId

#Get user's last sign-in information
Get-AzureADAuditSignInLogs -Filter "UserPrincipalName eq 'UserPrincipalName'" -Top 1     

#Get user's last password change information
Get-AzureADAuditDirectoryLogs -Filter "TargetResources/any(tr: tr/displayName eq 'UserPrincipalName' and tr/type eq 'User')" -Top 1 | Where-Object {$_.ActivityDisplayName -eq "Change user password"}  

#Get MFA status for a specific user
Get-AzureADUser -ObjectId (Get-AzureADUser -ObjectId "UserPrincipalName").ObjectId | Select-Object -ExpandProperty StrongAuthenticationMethods

#Get user's device information
Get-AzureADUserRegisteredDevice -ObjectId (Get-AzureADUser -ObjectId "UserPrincipalName").ObjectId

#Get user's group memberships
Get-AzureADUserMembership -ObjectId (Get-AzureADUser -ObjectId "UserPrincipalName").ObjectId

#Get user's devices
Get-AzureADUserOwnedDevice -ObjectId (Get-AzureADUser -ObjectId "UserPrincipalName").ObjectId

#Get all users in a specific group
$group = Get-AzureADGroup -SearchString "GroupName" 
Get-AzureADGroupMember -ObjectId $group.ObjectId

#Get information about a specific device
Get-AzureADDevice -ObjectId (Get-AzureADDevice -SearchString "DeviceName").ObjectId

#Get information about a specific group
Get-AzureADGroup -ObjectId (Get-AzureADGroup -SearchString "GroupName").ObjectId

#Get list of all roles assigned to a specific user
Get-AzureADUserAppRoleAssignment -ObjectId (Get-AzureADUser -ObjectId "UserPrincipalName").ObjectId

#Get list of all licenses
Get-AzureADSubscribedSku

#Get list of all applications
Get-AzureADApplication -All $true

#Get list of all service principals
Get-AzureADServicePrincipal -All $true

#Get list of all roles
Get-AzureADDirectoryRole

#Get list of all role members for a specific role
$role = Get-AzureADDirectoryRole | Where-Object {$_.DisplayName -eq "Global Administrator"}
Get-AzureADDirectoryRoleMember -ObjectId $role.ObjectId

#Get list of all conditional access policies
Get-AzureADMSConditionalAccessPolicy

#Get list of all signed-in users
Get-AzureADAuditSignInLogs -All $true

#Get list of all audit logs
Get-AzureADAuditDirectoryLogs -All $true

#Get list of all password policies
Get-AzureADPolicy | Where-Object {$_.Type -eq "PasswordPolicies"}

#Get list of all device configurations
Get-AzureADDeviceConfiguration

#Get list of all identity providers
Get-AzureADIdentityProvider

#Get list of all B2B collaboration invitations
Get-AzureADMSInvitation -All $true

#Get list of all B2B collaboration users
Get-AzureADUser -Filter "UserType eq 'Guest'" -All $true

#Get all guest users
Get-AzureADUser -Filter "UserType eq 'Guest'" -All $true

#Get all guest users invitations
Get-AzureADMSInvitation -All $true

#Get all guest users and their invitations
$guests = Get-AzureADUser -Filter "UserType eq 'Guest'" -All $true
foreach ($guest in $guests) {
    $invitation = Get-AzureADMSInvitation -Filter "InvitedUserEmailAddress eq '$($guest.UserPrincipalName)'" 
    [PSCustomObject]@{
        GuestUserPrincipalName = $guest.UserPrincipalName
        InvitationStatus = $invitation.Status
        InvitedBy = $invitation.InvitedByDisplayName
        InvitedOn = $invitation.InvitedOn
    }
}

#Get all guest users added in the last 30 days
$cutoffDate = (Get-Date).AddDays(-30)
Get-AzureADUser -Filter "UserType eq 'Guest' and CreationDateTime ge $($cutoffDate.ToString("o"))" -All $true

#Get all guest users invited by a specific user
$inviter = "<UserPrincipalName>"
$invitations = Get-AzureADMSInvitation -All $true | Where-Object {$_.InvitedByUserId -eq (Get-AzureADUser -ObjectId $inviter).ObjectId}
foreach ($invitation in $invitations) {
    Get-AzureADUser -ObjectId (Get-AzureADUser -Filter "UserPrincipalName eq '$($invitation.InvitedUserEmailAddress)'" -All $true).ObjectId
}

#Get all guest users who have accepted their invitations
Get-AzureADMSInvitation -All $true | Where-Object {$_.Status -eq "Accepted"} | ForEach-Object {
    Get-AzureADUser -ObjectId (Get-AzureADUser -Filter "UserPrincipalName eq '$($_.InvitedUserEmailAddress)'" -All $true).ObjectId
}

#Get all guest users who have not accepted their invitations
Get-AzureADMSInvitation -All $true | Where-Object {$_.Status -ne "Accepted"} | ForEach-Object {
    Get-AzureADUser -ObjectId (Get-AzureADUser -Filter "UserPrincipalName eq '$($_.InvitedUserEmailAddress)'" -All $true).ObjectId
}

#Get all users who have not signed in in the last 90 days
$cutoffDate = (Get-Date).AddDays(-90)
Get-AzureADUser -All $true | Where-Object {
    $signInLogs = Get-AzureADAuditSignInLogs -Filter "UserPrincipalName eq '$($_.UserPrincipalName)'" -Top 1
    if ($signInLogs) {
        $lastSignIn = $signInLogs[0].CreatedDateTime
        return $lastSignIn -lt $cutoffDate
    } else {
        return $true
    }
}

