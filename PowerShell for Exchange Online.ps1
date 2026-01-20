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

#Get list of all mailboxes
Get-Mailbox -ResultSize Unlimited

#Get list of all distribution groups
Get-DistributionGroup -ResultSize Unlimited

#Get list of all mail contacts
Get-MailContact -ResultSize Unlimited

#Get list of all mail users
Get-MailUser -ResultSize Unlimited

#Get list of all shared mailboxes
Get-Mailbox -RecipientTypeDetails SharedMailbox -ResultSize Unlimited

#Get list of all resource mailboxes (room and equipment)
Get-Mailbox -RecipientTypeDetails RoomMailbox, EquipmentMailbox -ResultSize Unlimited

#Get list of all dynamic distribution groups
Get-DynamicDistributionGroup -ResultSize Unlimited

#Get list of all mail-enabled security groups
Get-DistributionGroup -RecipientTypeDetails MailUniversalSecurityGroup, MailNonUniversalGroup -ResultSize Unlimited

#Get list of all email address policies
Get-EmailAddressPolicy

#Get list of all accepted domains
Get-AcceptedDomain

#Get list of all remote domains
Get-RemoteDomain

#Get list of all transport rules
Get-TransportRule

#Get list of all mail flow connectors
Get-TransportConnector

#Get list of all mobile device mailbox policies
Get-MobileDeviceMailboxPolicy

#Get list of all retention policies
Get-RetentionPolicy

#Get list of all retention tags
Get-RetentionPolicyTag

#Get list of all mailbox audit log entries for a specific mailbox
Search-MailboxAuditLog -Mailboxes

#Get list of all mailbox permissions for a specific mailbox
Get-MailboxPermission -Identity

#Get list of all send-as permissions for a specific mailbox
Get-RecipientPermission -Identity

#Get list of all send-on-behalf permissions for a specific mailbox
Get-Mailbox -Identity | Select-Object -ExpandProperty GrantSendOnBehalfTo   

#Get list of all email forwarding settings for a specific mailbox
Get-Mailbox -Identity | Select-Object -ExpandProperty ForwardingSmtpAddress, ForwardingAddress

#Get list of all mailbox size and usage statistics
Get-MailboxStatistics -Identity

#Get list of all inactive mailboxes
Get-Mailbox -InactiveMailboxOnly -ResultSize Unlimited

#Get list of all litigation hold enabled mailboxes
Get-Mailbox -Filter {LitigationHoldEnabled -eq $true} -ResultSize Unlimited

# Enable litigation hold for a specific mailbox
Set-Mailbox -Identity "<mailbox_email>" -LitigationHoldEnabled $true -LitigationHoldDuration 365

#Get list of all mailboxes with specific custom attribute
Get-Mailbox -Filter {CustomAttribute1 -eq "Value"} -ResultSize Unlimited

#Get list of all mailboxes with specific email address
Get-Mailbox -ResultSize Unlimited | Where-Object { $_.EmailAddresses -like "*@domain.com*" }    

#Get list of all mailboxes with specific mailbox size (e.g., greater than 1GB)
Get-MailboxStatistics -ResultSize Unlimited | Where-Object { $_.TotalItemSize -gt 1GB } 

#Get list of all mailboxes that have not been accessed in the last 90 days
$cutoffDate = (Get-Date).AddDays(-90)
Get-MailboxStatistics -ResultSize Unlimited | Where-Object { $_.LastLogonTime -lt $cutoffDate }     

# Share a calendar from one user to another with specific permissions
$calendarOwner = "<calendar_owner_email>:Calendar"
$calendarUser = "<calendar_user_email>"
Add-MailboxFolderPermission -Identity $calendarOwner -User $calendarUser -AccessRights FullAccess

#Share a calendar from one user to another with reviewer permissions
$calendarOwner = "<calendar_owner_email>:Calendar"
$calendarUser = "<calendar_user_email>"
Add-MailboxFolderPermission -Identity $calendarOwner -User $calendarUser -AccessRights Reviewer

#Share a calendar from one user to another with limited permissions
$calendarOwner = "<calendar_owner_email>:Calendar"
$calendarUser = "<calendar_user_email>"
Add-MailboxFolderPermission -Identity $calendarOwner -User $calendarUser -AccessRights LimitedDetails

#Share a mailbox from one user to another with title and description permissions
Add-MailboxPermission -Identity "<mailbox_email>" -User "<user_email>" -AccessRights ReadPermissions

#Share a mailbox from one user to another with reviewer permissions
Add-MailboxPermission -Identity "<mailbox_email>" -User "<user_email>" -AccessRights Reviewer

#Share a mailbox from one user to another with specific permissions
Add-MailboxPermission -Identity "<mailbox_email>" -User "<user_email>" -AccessRights FullAccess

#Grant send-as permission to a user for a specific mailbox
Add-RecipientPermission -Identity "<mailbox_email>" -Trustee "<user_email>" -AccessRights SendAs

#Grant send-on-behalf permission to a user for a specific mailbox
Set-Mailbox -Identity "<mailbox_email>" -GrantSendOnBehalfTo "<user_email>"

#Grant send-on-behalf permission to a group for a specific mailbox
Set-Mailbox -Identity "<mailbox_email>" -GrantSendOnBehalfTo "<group_email>"

#Grant send-as permission to a group for a specific mailbox
Add-RecipientPermission -Identity "<mailbox_email>" -Trustee "<group_email>" -AccessRights SendAs

#Grant full access permission to a user for a specific mailbox
Add-MailboxPermission -Identity "<mailbox_email>" -User "<user_email>" -AccessRights FullAccess

#Grant full access permission to a group for a specific mailbox
Add-MailboxPermission -Identity "<mailbox_email>" -User "<group_email>" -AccessRights FullAccess

# Set automatic replies for a specific mailbox
Set-MailboxAutoReplyConfiguration -Identity "<mailbox_email>" -AutoReplyState Enabled -InternalMessage "I am currently out of the office." -ExternalMessage "I am currently out of the office." 

# Enable mailbox auditing for a specific mailbox
Set-Mailbox -Identity "<mailbox_email>" -AuditEnabled $true

# Set email forwarding for a specific mailbox
Set-Mailbox -Identity "<mailbox_email>" -ForwardingSmtpAddress "forwardto@domain.com" -DeliverToMailboxAndForward $true