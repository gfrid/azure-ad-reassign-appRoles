# Azure AD PowerShell - Re-assign AppRoles to new cloud groups
Azure-AD powershell script for removing and re-assigning AppRoles to other/new cloud groups

# Problem and workaround
If you need to migrate on-prem AD groups to cloud groups there is no easy way to do it.
This script helps to workaround this problem by re-creating groups as 'Cloud Only' groups
removing attached AppRoles of exisitng groups, creating new cloud only groups and attaching 
exisitng AppRoles to them. Once its done you can remove ADSync and rename the new groups to
original naming.

# How does it work
1. Get AppRole IDs and detach them from AD synced AD Groups
2. Crate new Cloud groups with (+) in the begining 
3. Attach AppRoles (from previous step) to new temp Cloud groups

*Rename to origin name (not in script)
