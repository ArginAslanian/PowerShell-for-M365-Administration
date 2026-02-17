# Set execution policy (recommended: CurrentUser scope to avoid org-wide changes)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

#Install the Exhange Online Management module if not already installed
if (-not (Get-Module -ListAvailable -Name ExchangeOnlineManagement)) {
    Install-Module -Name ExchangeOnlineManagement -Scope CurrentUser -Force
}

# Import the Exchange Online Management module
Import-Module ExchangeOnlineManagement

# Connect to Exchange Online
Connect-ExchangeOnline -UserPrincipalName admin@xyz.com

#Disconnect from Exchange Online
Disconnect-ExchangeOnline


################################################################
###### Mailbox Operations
################################################################

# List mailbox permissions for a specific mailbox
Get-MailboxPermission -Identity "mailbox_email"

# List send-as permissions for a specific mailbox
Get-RecipientPermission -Identity "mailbox_email"

# List send-on-behalf permissions for a specific mailbox
Get-Mailbox -Identity "mailbox_email" | Select-Object -ExpandProperty GrantSendOnBehalfTo

# Share a mailbox from one user to another with specific permissions
Add-MailboxPermission -Identity "mailbox_email" -User "user_email" -AccessRights FullAccess

# Grant send-as permission to a user for a specific mailbox
Add-RecipientPermission -Identity "mailbox_email" -Trustee "user_email" -AccessRights SendAs

# Grant send-on-behalf permission to a user for a specific mailbox
Set-Mailbox -Identity "mailbox_email" -GrantSendOnBehalfTo "user_email"

# Remove mailbox permissions for a specific mailbox
Remove-MailboxPermission -Identity "mailbox_email" -User "user_email" -AccessRights FullAccess

# Remove send-as permission for a user for a specific mailbox
Remove-RecipientPermission -Identity "mailbox_email" -Trustee "user_email" -AccessRights SendAs

# Remove send-on-behalf permission for a user for a specific mailbox
Set-Mailbox -Identity "mailbox_email" -GrantSendOnBehalfTo $null

# Edit mailbox permissions for a specific mailbox
Set-MailboxPermission -Identity "mailbox_email" -User "user_email" -AccessRights ReadPermissions

# Set automatic replies for a specific mailbox
Set-MailboxAutoReplyConfiguration -Identity "mailbox_email" -AutoReplyState Enabled -InternalMessage "I am currently out of the office." -ExternalMessage "I am currently out of the office."

# Remove automatic replies for a specific mailbox
Set-MailboxAutoReplyConfiguration -Identity "mailbox_email" -AutoReplyState Disabled

# Check automatic reply configuration for a specific mailbox
Get-MailboxAutoReplyConfiguration -Identity "mailbox_email"

# List email forwarding settings for a specific mailbox
Get-Mailbox -Identity "mailbox_email" | Select-Object -ExpandProperty ForwardingSmtpAddress, ForwardingAddress

# Set email forwarding for a specific mailbox
Set-Mailbox -Identity "<mailbox_email>" -ForwardingSmtpAddress "forwardto@domain.com" -DeliverToMailboxAndForward $true

# Remove email forwarding for a specific mailbox
Set-Mailbox -Identity "<mailbox_email>" -ForwardingSmtpAddress $null -DeliverToMailboxAndForward $false

# Get list of all shared mailboxes
Get-Mailbox -RecipientTypeDetails SharedMailbox -ResultSize Unlimited

################################################################
###### Calendar Operations
################################################################

# List calendar permissions for a specific calendar
Get-MailboxFolderPermission -Identity xyz@abc.com:\Calendar

# Share a calendar from one user to another with specific permissions
Add-MailboxFolderPermission -Identity "calendar_owner_email:\Calendar" -User "calendar_user_email" -AccessRights FullAccess

# Share a calendar from one user to another with reviewer permissions
Add-MailboxFolderPermission -Identity "calendar_owner_email:\Calendar" -User "calendar_user_email" -AccessRights Reviewer

# Share a calendar from one user to another with limited permissions
Add-MailboxFolderPermission -Identity "calendar_owner_email:\Calendar" -User "calendar_user_email" -AccessRights LimitedDetails

# Remove calendar permissions for a specific calendar
Remove-MailboxFolderPermission -Identity "calendar_owner_email:\Calendar" -User "calendar_user_email" -AccessRights FullAccess

# Edit calendar permissions for a specific calendar
Set-MailboxFolderPermission -Identity "calendar_owner_email:\Calendar" -User "calendar_user_email" -AccessRights ReadPermissions

################################################################
###### Distribution Group Operations
################################################################

# Get list of all distribution groups
Get-DistributionGroup -ResultSize Unlimited

# Get list of all members of a specific distribution group
Get-DistributionGroupMember -Identity "Group Name"

# Add a member to a specific distribution group
Add-DistributionGroupMember -Identity "Group Name" -Member "user@domain.com"

# Remove a member from a specific distribution group
Remove-DistributionGroupMember -Identity "Group Name" -Member "user@domain.com"

################################################################
###### Other Useful Operations
################################################################

# Get list of all resource mailboxes (room and equipment)
Get-Mailbox -RecipientTypeDetails RoomMailbox, EquipmentMailbox -ResultSize Unlimited

# Get list of all inactive mailboxes
Get-Mailbox -InactiveMailboxOnly -ResultSize Unlimited

# Get list of all litigation hold enabled mailboxes
Get-Mailbox -Filter {LitigationHoldEnabled -eq $true} -ResultSize Unlimited

# Enable litigation hold for a specific mailbox
Set-Mailbox -Identity "<mailbox_email>" -LitigationHoldEnabled $true -LitigationHoldDuration 365

# Set automatic replies for a specific mailbox
Set-MailboxAutoReplyConfiguration -Identity "<mailbox_email>" -AutoReplyState Enabled -InternalMessage "I am currently out of the office." -ExternalMessage "I am currently out of the office." 

# Enable mailbox auditing for a specific mailbox
Set-Mailbox -Identity "<mailbox_email>" -AuditEnabled $true
