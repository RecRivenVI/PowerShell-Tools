$screenshots = Get-ChildItem -Path "F:\PhotoSync\DCIM\Screenshots" |
ForEach-Object -Parallel {
    $screenshotsFile = $_
$name = $screenshotsFile.Name
$result = ($name.Substring(35)) -replace '\.(jpg|png)$',''

    [PSCustomObject]@{
        PackageName = $result
        Name     = $screenshotsFile.Name
        FullName = $screenshotsFile.FullName

    }
} -ThrottleLimit 8

$screenshots |
Sort-Object Name |
Export-Csv -Path "$PSScriptRoot/screenshotsInfo.csv" -Encoding UTF8 -NoTypeInformation
