# MsGraph Permissions for Entra ID

# Directory.Read.All                    Read all directory objects (users, groups, devices, roles)
# Directory.ReadWrite.All               Read and modify all directory objects
# User.Read.All                         Read all users’ full profiles
# User.ReadWrite.All                    Read and update user profiles   
# Group.Read.All                        Read all groups and group memberships
# Group.ReadWrite.All                   Create, modify, and delete groups
# RoleManagement.Read.Directory         Read directory role definitions and assignments
# RoleManagement.ReadWrite.Directory    Manage directory roles and assignments
# Device.Read.All                       Read all registered and joined devices
# AuditLog.Read.All                     Read Entra ID audit logs and sign‑in logs
# Policy.Read.All                       Read conditional access and other directory policies
# Policy.ReadWrite.ConditionalAccess    Create and modify Conditional Access policies
# Policy.ReadWrite.AuthenticationMethods  Create and modify authentication method policies

######################################################################################################

# MsGraph Permission for Intune

# DeviceManagementManagedDevices.Read.All       Read managed device properties
# DeviceManagementManagedDevices.ReadWrite.All  Manage (wipe, retire, sync) devices
# DeviceManagementConfiguration.Read.All        Read device configuration profiles
# DeviceManagementConfiguration.ReadWrite.All   Create and modify configuration profiles
# DeviceManagementApps.Read.All                 Read Intune application inventory
# DeviceManagementApps.ReadWrite.All            Deploy and manage Intune applications
# DeviceManagementServiceConfig.Read.All        Read Intune tenant-level settings
# DeviceManagementServiceConfig.ReadWrite.All   Modify Intune tenant settings
# DeviceManagementRBAC.Read.All                Read Intune role-based access control settings
# DeviceManagementRBAC.ReadWrite.All           Create and modify Intune role-based access control settings

######################################################################################################

# MsGraph Permission for Exchange Online

# Mail.Read                     Read all mail in all user mailboxes
# Mail.ReadWrite                Read and modify all mail
# Mail.Send                     Send mail as any user
# MailboxSettings.Read          Read user mailbox settings
# MailboxSettings.ReadWrite     Modify mailbox settings
# Calendars.Read                Read all calendars
# Calendars.ReadWrite           Read and update calendars
# Contacts.Read                 Read all mailbox contacts
# Reports.Read.All              Read Exchange usage and activity reports