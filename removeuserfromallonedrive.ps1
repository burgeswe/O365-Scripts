$removeUser = "enter username to remove"
$AllSites = Import-Csv C:\Scripts_Output\allonedrive.csv
$spourl = "enter sharepoint admin url"

Connect-SPOService -Url $spourl

$myArray = [System.Collections.ArrayList]@()

foreach ($url in $AllSites.OneDriveSiteUrl)
{
#set the site collection admin
Set-SPOUser -Site $url -LoginName $removeUser -IsSiteCollectionAdmin $true | out-null
write-host "Getting site collection admins for"$url -ForegroundColor green

#get all the site collection admins
$myarray = Get-SPOUser -Site $url | where {$_.IsSiteAdmin}

#remove user from the array
$data = $myarray | ? {$_.UserName -ne $removeUser}

#remove user as site collection admin
Set-SPOUser -Site $url -LoginName $removeUser -IsSiteCollectionAdmin $false |out-null -ErrorAction silentlycontinue


$data |
select DisplayName ,LoginName, Groups, @{Name='URL';Expression={[string]$url}} | Export-Csv -path "C:\Scripts_Output\siteadmins.csv" -NoTypeInformation -Encoding UTF8
}