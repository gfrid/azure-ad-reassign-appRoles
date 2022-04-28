$groups = get-azadgroup -DisplayNameStartsWith "AWS-" | Select DisplayName, Description, id
foreach ($d in $groups) {
   write-host $d.DisplayName
   $d.DisplayName = $d.DisplayName -replace "AWS", "+AWS" 
   #checking new name to validate its changed in replace
   $d.DisplayName
   $d.Description
   #New-AzureADGroup -DisplayName $d.DisplayName -MailEnabled $false -SecurityEnabled $true -MailNickName "NotSet" -Description $d.Description
   }

#REMOVE APPROLE ASSIGN

$groups = get-azadgroup -DisplayNameStartsWith "AWS-" | Select DisplayName, Description, id
foreach ($i in $groups) {

  $assign = Get-AzureADGroupAppRoleAssignment -ObjectId $i.id 
      # foreach ($text in $assign.PrincipalDisplayName) {
            $separator = "-"
            $parts = $assign.PrincipalDisplayName.split($separator)
            $acc = $parts[1]
            $role = $parts[2]
            $acc, $role
            $app_name = "AWS-x Single Sign-on"
            $sp = Get-AzureADServicePrincipal -Filter "displayName eq '$app_name'"
            foreach ($a in $acc) {
              foreach ($r in $role) {
                $appRole = $sp.AppRoles | Where-Object { $_.DisplayName -match "\b$role\b" -and $_.DisplayName -match $acc } 
                write-host $appRole.DisplayName $appRole.id $assign.PrincipalDisplayName -background green
                #Remove-AzureADGroupAppRoleAssignment -ObjectId $i.id ? -AppRoleAssignmentId ? <-MSFT what is this
             }
            }
         }
       #  }

#ADD NEW APPROLE ASSIGN

$groups = get-azadgroup -DisplayNameStartsWith "+AWS-" | Select DisplayName, Description, id
foreach ($i in $groups) {

  $assign = Get-AzureADGroupAppRoleAssignment -ObjectId $i.id 
       #foreach ($text in $assign.PrincipalDisplayName) {
            $separator = "-"
            $parts = $assign.PrincipalDisplayName.split($separator)
            $acc = $parts[1]
            $role = $parts[2]
            $acc, $role
            $app_name = "AWS-x Single Sign-on"
            $sp = Get-AzureADServicePrincipal -Filter "displayName eq '$app_name'"
            foreach ($a in $acc) {
              foreach ($r in $role) {
                $appRole = $sp.AppRoles | Where-Object { $_.DisplayName -match "\b$role\b" -and $_.DisplayName -match $acc } 
                write-host $appRole.DisplayName $appRole.id $assign.PrincipalDisplayName -background green
                #New-AzureADGroupAppRoleAssignment -ObjectId $i.id  -PrincipalId $i.id -ResourceId $sp.ObjectId -Id $appRole.Id
             }
            }
         }
        # }

#Some TESTS

 $groups = get-azadgroup -DisplayNameStartsWith "AWS-" | Select DisplayName, Description, id
    foreach ($i in $groups) {
    Get-AzureADGroupAppRoleAssignment -ObjectId $i.id 
}
