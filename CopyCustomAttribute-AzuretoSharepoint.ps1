#Variables
$credUser = "#username"
$credPass = ConvertTo-SecureString -String "#password" -AsPlainText -Force
$credential= New-Object -TypeName System.Management.Automation.PSCredential -Argumentlist ($credUser,$credPass)
$appSiteUrl = "sharepoint admin site url"
$property = "custom property name"

Connect-PnPOnline -Url $appSiteUrl -Credentials $credential
Connect-AzureAD -Credential $credential
$conn = Get-PnPConnection
 
Get-AzureADUser -All $true | ForEach-Object {
    if ($_.ExtensionProperty.ContainsKey("$property")) {
        $adValue = $_.ExtensionProperty.Item("$property")
        Set-PnPUserProfileProperty -Account $_.UserPrincipalName.ToString() -PropertyName $property -Value $adValue
    }
}