#User Images will need to be named the same as the userID

$userPictureFolder = 'folder with user pictures'

Connect-ExchangeOnline

foreach ($picture in Get-ChildItem $userPictureFolder)
{
    try
    {
        Set-UserPhoto  `
            -Identity "$picture.BaseName" `
            -PictureData ([System.IO.File]::ReadAllBytes(“$userPictureFolder\$($picture.Name)”)) `
            -Confirm:$false
    }
}