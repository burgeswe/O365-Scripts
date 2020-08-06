$source = #path to compressed directory with backgrounds

Start-BitsTransfer -Source $source -Destination $env:temp
$filename =  Split-Path -Path $source -Leaf
if(test-path -Path $env:temp\CustomBackgrounds)
  {
    remove-item $env:temp\CustomBackgrounds -Recurse -Force
  }
Expand-Archive -LiteralPath $env:TEMP\$filename -DestinationPath "$env:temp\TeamsBackgrounds" -Force

$TeamsBGImages = "$env:temp\TeamsBackgrounds"
$teamsBGPath = "$env:APPDATA\Microsoft\Teams\Backgrounds\Uploads"

if (-not (Test-Path "$teamsBGPath")) 
{New-Item "$teamsBGPath" -type directory}

Copy-Item -Force -Recurse -Path $TeamsBGImages -Filter *.* -Destination $teamsBGPath -Container:$false
