# Connect to SharePoint with scopes for sharepoint sites,
# harepoint admin and user read, sharepoint write, Onedrive read and write, OneDrive Permissions.All - scopes variable based on requirements
Connect-MgGraph -Scopes "Sites.Read.All","Sites.Manage.All","Sites.FullControl.All","User.Read","User.ReadWrite.All","Files.Read.All","Files.ReadWrite.All","Files.ReadWrite.AppFolder","Sites.Selected"    

# Verify Connection
Get-MgContext

# Disconnect from SharePoint
Disconnect-MgGraph

# List all SharePoint sites
Get-MgSite -All

# View a specific SharePoint site by its ID
Get-MgSite -SiteId "<site-id>"      

# View a specific SharePoint site by its URL
Get-MgSite -SiteId "root:/sites/<site-name>"    

# List all lists in a SharePoint site
Get-MgSiteList -SiteId "<site-id>" -All

# Create a link to OneDrive files of a user to share
New-MgUserDriveItemCreateLink -UserId "<user-id>" -ItemId "<item-id>" -Type "view" -Scope "anonymous"

# Create a link to OneDrive files of a former user to share
New-MgUserDriveItemCreateLink -UserId "<former-user-id>" -ItemId "<item-id>" -Type "view" -Scope "anonymous"

# Create a link to OneDrive files of a user to share within organization
New-MgUserDriveItemCreateLink -UserId "<user-id>" -ItemId "<item-id>" -Type "edit" -Scope "organization"

# Create a link to OneDrive files of the signed-in user to share
New-MgMeDriveItemCreateLink -ItemId "<item-id>" -Type "edit" -Scope "organization"

# Grant access to a user to view another user's all OneDrive files
New-MgUserDriveItemInvite -UserId "<owner-user-id>" -ItemId "<item-id>" -Recipients @(@{Email="<recipient-email>"})

# View OneDrive usage details for a user
Get-MgReportUserCredentialUsageDetails -Period "D7" | Where-Object {$_.UserPrincipalName -eq "<user-principal-name>"}

# View SharePoint site usage details
Get-MgReportSiteUsageDetail -Period "D7" | Where-Object {$_.SiteUrl -eq "https://<domain>.sharepoint.com/sites/<site-name>"}

# View SharePoint site usage pages
Get-MgReportSiteUsagePages -Period "D7" | Where-Object {$_.SiteUrl -eq "https://<domain>.sharepoint.com/sites/<site-name>"}

# SharePoint statistics report for all sites
Get-MgReportSharePointSiteUsageFileCounts -Period "D7"
