$MiCameraStatue = Get-ChildItem -Path "F:\PhotoSync\DCIM\CameraMissingMiCameraDUPE" -File |
ForEach-Object -Parallel {
    $JpgFile              = $_
    $ExifTool             = "D:\Tools\ExifTool\exiftool.exe"
    $ExifDateTimeOriginal = & $ExifTool -DateTimeOriginal -s3 $JpgFile.FullName
    $ExifThumbnailImage   = & $ExifTool -ThumbnailImage -s3 $JpgFile.FullName
    $ExifMake             = & $ExifTool -Make -s3 $JpgFile.FullName
    $ExifModel            = & $ExifTool -Model -s3 $JpgFile.FullName
    $ExifXiaomiModel      = & $ExifTool -XiaomiModel -s3 $JpgFile.FullName
    $XmpData              = & $ExifTool -X $JpgFile.FullName
    $XmpMiCamera          = $XmpData | Select-String -Pattern "XMP-MiCamera"
    $XmpGPano             = $XmpData | Select-String -Pattern "XMP-GPano"
    $XmpGCamera           = $XmpData | Select-String -Pattern "XMP-GCamera"
    $XmpdocPhoto          = $XmpData | Select-String -Pattern "docPhoto"
    $XmpMicroVideo        = $XmpData | Select-String -Pattern "MicroVideo"
    $XmpMotionPhoto       = $XmpData | Select-String -Pattern "MotionPhoto"
    [PSCustomObject]@{
        Name                 = $JpgFile.Name
        ExifDateTimeOriginal = $ExifDateTimeOriginal ? $ExifDateTimeOriginal : "NOT FOUND"
        ExifMake             = $ExifMake ? $ExifMake : "NOT FOUND"
        ExifModel            = $ExifModel ? $ExifModel : "NOT FOUND"
        ExifXiaomiModel      = $ExifXiaomiModel ? $ExifXiaomiModel : "NOT FOUND"
        XmpMiCamera          = $XmpMiCamera ? "YES" : "NO"
        XmpGPano             = $XmpGPano ? "YES" : "NO"
        XmpGCamera           = $XmpGCamera ? "YES" : "NO"
        ExifThumbnailImage   = $ExifThumbnailImage ? "YES" : "NO"
        XmpdocPhoto          = $XmpdocPhoto ? "YES" : "NO"
        XmpMicroVideo        = $XmpMicroVideo ? "YES" : "NO"
        XmpMotionPhoto       = $XmpMotionPhoto ? "YES" : "NO"
        FullName             = $JpgFile.FullName
    }
} -ThrottleLimit 8

$MiCameraStatue |
Sort-Object Name |
Export-Csv -Path "$PSScriptRoot/PhotoInfo.csv" -Encoding UTF8 -NoTypeInformation
