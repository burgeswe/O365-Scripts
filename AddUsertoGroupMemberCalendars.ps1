Import-Module ActiveDirectory

$calendars = Get-ADGroupMember -Identity "owners" | Where objectclass -eq 'user' | Get-ADUser -Properties samAccountName,mail | select samAccountName,mail
$reviewerEmailAddress = 'email address of user or group to add as reviewers'
#AccessRights Variable can be set to a list of things listed at https://docs.microsoft.com/en-us/powershell/module/exchange/add-mailboxfolderpermission?view=exchange-ps
$AccessRights = Reviewer

Connect-ExchangeOnline

ForEach ($user in $calendars)
    {
    Add-MailboxFolderPermission (""+ $user.mail+ ":\Calendar") -User $reviewerEmailAddress -AccessRights $AccessRights
    }
