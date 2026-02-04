# Connect to Microsoft Graph for Exchange Online and Calendar management
Connect-MgGraph -Scopes Mail.ReadWrite, Calendars.ReadWrite

# Verify Connection
Get-MgContext

# Disconnect from Exchange Online
Disconnect-MgGraph

# List all mailboxes
Get-MgUser -All | Where-Object { $_.Mail -ne $null }

# View a mailbox's details
Get-MgUser -UserId "<mailbox-id>"

# Give access to a mailbox to another user
Add-MgUserPermission -UserId "<mailbox-id>" -GrantedToUserId "<user-id>" -Roles @("FullAccess") 

# Remove access to a mailbox from another user
Remove-MgUserPermission -UserId "<mailbox-id>" -GrantedToUserId "<user-id>"

# Check mailbox permissions
Get-MgUserPermission -UserId "<mailbox-id>"

# View all users with access to a mailbox
Get-MgUserPermission -UserId "<mailbox-id>" | Select-Object GrantedTo  

# View a user's calendar events
Get-MgUserCalendarEvent -UserId "<user-id>"

# Grant calendar access to another user
Add-MgUserCalendarPermission -UserId "<user-id>" -CalendarId "calendar" -GrantedToUserId "<grantee-user-id>" -Roles @("Editor")

# Revoke calendar access from another user
Remove-MgUserCalendarPermission -UserId "<user-id>" -CalendarId "calendar" -GrantedToUserId "<grantee-user-id>"

# Check calendar permissions
Get-MgUserCalendarPermission -UserId "<user-id>" -CalendarId "calendar"

# Check all users with access to a calendar
Get-MgUserCalendarPermission -UserId "<user-id>" -CalendarId "calendar" | Select-Object GrantedTo

# View distribution groups
Get-MgGroup -Filter "groupTypes/any(c:c eq 'Unified')" -All

# Get the object ID of a distribution group
Get-MgGroup -Filter "displayName eq 'Group Name'"

# View members of a distribution group
Get-MgGroupMember -GroupId "<group-id>" -All

# View members of a distribution group by distribution list email address
$group = Get-MgGroup -Filter "mail eq 'group@domain.com'"
Get-MgGroupMember -GroupId $group.Id -All

# Add a member to a distribution group
Add-MgGroupMember -GroupId "<group-id>" -DirectoryObjectId "<user-id>"

# Remove a member from a distribution group
Remove-MgGroupMember -GroupId "<group-id>" -DirectoryObjectId "<user-id>"

# Create a new distribution group
New-MgGroup -DisplayName "New Distribution Group" -MailEnabled $true -MailNickname "newdistgroup" -SecurityEnabled $false -GroupTypes @("Unified")  

# Delete a distribution group
Remove-MgGroup -GroupId "<group-id>"

# Grant admin access to a user to manage a distribution group
Add-MgGroupOwner -GroupId "<group-id>" -DirectoryObjectId "<user-id>"

# Revoke admin access from a user to manage a distribution group
Remove-MgGroupOwner -GroupId "<group-id>" -DirectoryObjectId "<user-id>"

# View owners of a distribution group
Get-MgGroupOwner -GroupId "<group-id>" -All

# Create a contact
New-MgContact -GivenName "John" -Surname "Doe" -EmailAddresses @(@{Address="john.doe@domain.com"})  

# Delete a contact
Remove-MgContact -ContactId "<contact-id>"

# Create a shared mailbox
New-MgUser -AccountEnabled $true -DisplayName "Shared Mailbox" -MailNickname "sharedmailbox" -UserPrincipalName "sharedmailbox@domain.com" -PasswordProfile @{Password = "InitialPassword123"; ForceChangePasswordNextSignIn = $false} -MailEnabled $true -SecurityEnabled $false   

# Delete a shared mailbox
Remove-MgUser -UserId "<shared-mailbox-id>"

# List all shared mailboxes
Get-MgUser -All | Where-Object { $_.MailEnabled -eq $true -and $_.SecurityEnabled -eq $false }

# Create a resource mailbox (room)
New-MgUser -AccountEnabled $true -DisplayName "Conference Room" -MailNickname "conferenceroom" -UserPrincipalName "conferenceroom@domain.com" -PasswordProfile @{Password = "InitialPassword123"; ForceChangePasswordNextSignIn = $false} -MailEnabled $true -SecurityEnabled $false

# Delete a resource mailbox (room)
Remove-MgUser -UserId "<resource-mailbox-id>"

# List all resource mailboxes (rooms)
Get-MgUser -All | Where-Object { $_.MailEnabled -eq $true -and $_.SecurityEnabled -eq $false -and $_.UserPrincipalName -like "*@domain.com" }   

# Update a resource mailbox's (room) details
Update-MgUser -UserId "<resource-mailbox-id>" -DisplayName "Updated Conference Room"

# Check resource mailbox (room) calendar permissions
Get-MgUserCalendarPermission -UserId "<resource-mailbox-id>" -CalendarId "calendar"

# Set resource mailbox (room) calendar permissions
Add-MgUserCalendarPermission -UserId "<resource-mailbox-id>" -CalendarId "calendar" -GrantedToUserId "<grantee-user-id>" -Roles @("Editor") 

# Remove resource mailbox (room) calendar permissions
Remove-MgUserCalendarPermission -UserId "<resource-mailbox-id>" -CalendarId "calendar" -GrantedToUserId "<grantee-user-id>"

# View a resource mailbox's (room) calendar events
Get-MgUserCalendarEvent -UserId "<resource-mailbox-id>"

# Update a resource auto booking settings
Update-MgUser -UserId "<resource-mailbox-id>" -AdditionalProperties @{"resourceProvisioningOptions" = @("AutoAcceptRequests")}  

# Update a resource mailbox's (room) display name
Update-MgUser -UserId "<resource-mailbox-id>" -DisplayName "Updated Room Name"  

# Update a resource mailbox's (room) capacity
Update-MgUser -UserId "<resource-mailbox-id>" -AdditionalProperties @{"resourceCapacity" = 20}

# Update a resource mailbox's (room) location
Update-MgUser -UserId "<resource-mailbox-id>" -AdditionalProperties @{"resourceLocation" = "1st Floor"}

# Update a resource mailbox's (room) phone number
Update-MgUser -UserId "<resource-mailbox-id>" -BusinessPhones @("+1 555-555-5555")

# Set up automatic replies for a mailbox
Update-MgUserMailboxSettings -UserId "<mailbox-id>" -AutomaticRepliesSetting @{Status = "Scheduled"; ExternalAudience = "All"; ScheduledStartDateTime = @{DateTime = "2024-07-01T09:00:00"; TimeZone = "Pacific Standard Time"}; ScheduledEndDateTime = @{DateTime = "2024-07-10T17:00:00"; TimeZone = "Pacific Standard Time"}; InternalReplyMessage = "I am currently out of the office."; ExternalReplyMessage = "I am currently out of the office."}    

# Clear automatic replies for a mailbox
Update-MgUserMailboxSettings -UserId "<mailbox-id>" -AutomaticRepliesSetting @{Status = "Disabled"}

# View a mailbox's automatic replies settings
Get-MgUserMailboxSettings -UserId "<mailbox-id>" | Select-Object -ExpandProperty AutomaticRepliesSetting

# Update a mailbox's signature
Update-MgUserMailboxSettings -UserId "<mailbox-id>" -SignatureHtml "<html><body><p>Best regards,<br/>John Doe</p></body></html>"

# View a mailbox's signature
Get-MgUserMailboxSettings -UserId "<mailbox-id>" | Select-Object -ExpandProperty SignatureHtml

# Clear a mailbox's signature
Update-MgUserMailboxSettings -UserId "<mailbox-id>" -SignatureHtml $null

# Set mailbox forwarding
Update-MgUserMailboxSettings -UserId "<mailbox-id>" -ForwardingSmtpAddress "<forwarding-address>"

# Clear mailbox forwarding
Update-MgUserMailboxSettings -UserId "<mailbox-id>" -ForwardingSmtpAddress $null

# View mailbox forwarding settings
Get-MgUserMailboxSettings -UserId "<mailbox-id>" | Select-Object -ExpandProperty ForwardingSmtpAddress

#########################################################################

# Exchange online security for emails
# Enable mailbox auditing
Update-MgUser -UserId "<mailbox-id>" -MailboxSettings @{AuditEnabled = $true}

# Disable mailbox auditing
Update-MgUser -UserId "<mailbox-id>" -MailboxSettings @{AuditEnabled = $false}

# View mailbox auditing settings
Get-MgUser -UserId "<mailbox-id>" | Select-Object -ExpandProperty MailboxSettings | Select-Object -ExpandProperty AuditEnabled

# Set mailbox retention policy
Update-MgUser -UserId "<mailbox-id>" -MailboxSettings @{RetentionPolicy = "Policy Name"}    

# View mailbox retention policy
Get-MgUser -UserId "<mailbox-id>" | Select-Object -ExpandProperty MailboxSettings | Select-Object -ExpandProperty RetentionPolicy

# Clear mailbox retention policy
Update-MgUser -UserId "<mailbox-id>" -MailboxSettings @{RetentionPolicy = $null}

# Enable email encryption for a mailbox
Update-MgUser -UserId "<mailbox-id>" -MailboxSettings @{SmtpEncryptionEnabled = $true}

# Disable email encryption for a mailbox
Update-MgUser -UserId "<mailbox-id>" -MailboxSettings @{SmtpEncryptionEnabled = $false}

# Check email statistics for a mailbox
Get-MgUserMailboxStatistics -UserId "<mailbox-id>"

# Check email stastistics for all mailboxes
Get-MgUser -All | Where-Object { $_.Mail -ne $null } | ForEach-Object { Get-MgUserMailboxStatistics -UserId $_.Id }

# View email threat protection settings for a mailbox
Get-MgUser -UserId "<mailbox-id>" | Select-Object -ExpandProperty MailboxSettings | Select-Object -ExpandProperty ThreatProtectionPolicy

