Set-Variable -Name "DistGroup" -Value "DGName"
Set-Variable -Name "DistGroupNew" -Value "DGName_New"
New-DistributionGroup -Name "$DistGroupNew" -DisplayName "$DistGroupNew" -Alias "$DistGroupNew"
Get-DistributionGroupMember -Identity $DistGroup | % {Add-DistributionGroupMember -Identity "$DistGroupNew" -Member $_.PrimarySmtpAddress}