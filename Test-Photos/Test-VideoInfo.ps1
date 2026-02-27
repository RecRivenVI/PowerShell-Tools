$MiCameraStatue = Get-ChildItem -Path "F:\PhotoSync\DCIM\CameraMP4" -File |
ForEach-Object -Parallel {
    $JpgFile              = $_
    $ExifTool             = "D:\Tools\ExifTool\exiftool.exe"
    $ExifDateTimeOriginal = & $ExifTool -CreateDate -s3 $JpgFile.FullName
    $XmpData              = & $ExifTool -X $JpgFile.FullName
    $Xmpdby1          = $XmpData | Select-String -Pattern "dby1"
    [PSCustomObject]@{
        Name                 = $JpgFile.Name
        ExifDateTimeOriginal = $ExifDateTimeOriginal ? $ExifDateTimeOriginal : "NOT FOUND"
        Xmpdby1          = $Xmpdby1 ? "YES" : "NO"
        FullName             = $JpgFile.FullName
    }
} -ThrottleLimit 8

$MiCameraStatue |
Sort-Object Name |
Export-Csv -Path "$PSScriptRoot/VideoInfo.csv" -Encoding UTF8 -NoTypeInformation
