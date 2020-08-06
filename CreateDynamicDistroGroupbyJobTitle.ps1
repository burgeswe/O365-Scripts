#Add the final name of the Distribution Group to $DistGroupName
#Add Job Titles 1-3, need to have beginning of title exactly correct, can only wildcard end of the Job Title
$DistGroupName = ''
$JobTitle1 = ''
$JobTitle2 = ''
$JobTitle3 = ''
$PrimaryEmail = ''

New-DynamicDistributionGroup -Name $DistGroupName -RecipientFilter "(RecipientType -eq 'UserMailbox') -and (Title -like '$JobTitle1*' -or Title -like '$JobTitle2*' -or Title -like '$JobTitle3*')" -PrimarySmtpAddress "$PrimaryEmail"

#Set Variable $DynDistMembers to pull users in new Dynamic Distro
$DynDistMembers = Get-DynamicDistributionGroup $DistGroupName

#Show users in new Dynamic Distro
Get-Recipient -RecipientPreviewFilter $DynDistMembers.RecipientFilter -OrganizationalUnit $DynDistMembers.RecipientContainer