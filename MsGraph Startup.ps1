# Set Execution Policy (if not using Core)
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Install MsGraph PowerShell SDK
Install-Module Microsoft.Graph -Repository PSGallery -Scope CurrentUser -Force

# Verify Installation
Get-InstalledModule Microsoft.Graph

#Verify Submodules and their versions
Get-InstalledModule

# Update the SDK
Update-Module Microsoft.Graph

# Uninstall the SDK
Uninstall-Module Microsoft.Graph -AllVersions

# Connect to Microsoft Graph with specific scopes/permissions
$scopes = @(
    "User.Read.All",
    "Group.ReadWrite.All",
    "DeviceManagementManagedDevices.ReadWrite.All",
    "Mail.ReadWrite"
)
Connect-MgGraph -Scopes $scopes

# Verify the connection and permissions
Get-MgContext

# Disconnect from Microsoft Graph
Disconnect-MgGraph