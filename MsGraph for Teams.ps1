# Connect to Microsoft Graph for Teams with appropriate scopes
Connect-MgGraph -Scopes "User.Read.All","Group.ReadWrite.All","Team.ReadBasic.All","Channel.ReadWrite.All"

# Verify Connection
Get-MgContext

# Disconnect from Microsoft Graph for Teams
Disconnect-MgGraph  

# List all Teams in the organization
Get-MgTeam -All

# View a Team's details
Get-MgTeam -TeamId "<team-id>"  

# View a Channel's details
Get-MgTeamChannel -TeamId "<team-id>" -ChannelId "<channel-id>"

# Create a new Team
New-MgTeam -DisplayName "New Team" -Description "Description of the new team" -Visibility "Private"

# Create a new Channel in a Team
New-MgTeamChannel -TeamId "<team-id>" -DisplayName "New Channel" -Description "Description of the new channel"

# Add a member to a Team
Add-MgTeamMember -TeamId "<team-id>" -UserId "<user-id>"

# Remove a member from a Team
Remove-MgTeamMember -TeamId "<team-id>" -UserId "<user-id>"

# List all members of a Team
Get-MgTeamMember -TeamId "<team-id>"

# Get Teams statistics
Get-MgTeamAnalytics -TeamId "<team-id>"