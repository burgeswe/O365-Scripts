$searchName = 'Enter Name of Compliance Center Search'

Connect-IPPSession
New-ComplianceSearchAction -SearchName $searchName -Purge -PurgeType HardDelete