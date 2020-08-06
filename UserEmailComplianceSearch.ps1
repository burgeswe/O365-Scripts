$userID = "user id to search"
$notifyEmail = "email address to notify when search is done"
$month = Get-Date -Format MM
$day = get-date -Format dd
$year = get-date -Format yyyy

# Get the Service Principal connection details for the Connection name
$credUser = "#username"
$credPass = ConvertTo-SecureString -String "password" -AsPlainText -Force
$exchCred = New-Object -TypeName System.Management.Automation.PSCredential -Argumentlist ($credUser,$credPass)

Connect-IPPSSession -Credential $exchCred

Get-ADUser -Identity $userID  -Properties * | Select-Object Displayname, userPrincipalName

#Start Mailbox Compliance Search and notify when it's complete
New-ComplianceCase -Name $user.userPrincipalName -Description "$($user.DisplayName) - $year-$month-$day"
New-CaseHoldPolicy -Name $user.userPrincipalName -Case $user.userPrincipalName -ExchangeLocation $user.userPrincipalName -Enabled $true
New-CaseHoldRule -Name $user.userPrincipalName -Policy $user.userPrincipalName -Disabled $false
New-ComplianceSearch -case $user.userPrincipalName -Name $user.userPrincipalName -ExchangeLocation $user.userPrincipalName -Description "$($user.DisplayName) Emails - $year-$month-$day"
Start-ComplianceSearch -Identity $user.userPrincipalName

#Wait for Compliance Search to finish
$ComplianceSearch = Get-ComplianceSearch -Identity $user.userPrincipalName
While ($ComplianceSearch.Status -ne "Completed") {
    Write-Host -NoNewline  "." -ForegroundColor DarkGray
    $ComplianceSearch = Get-ComplianceSearch -Identity $user.userPrincipalName
    }

#Export Compliance Search
New-ComplianceSearchAction -SearchName $user.userPrincipalName -Export -NotifyEmail $notifyEmail -Format FxStream