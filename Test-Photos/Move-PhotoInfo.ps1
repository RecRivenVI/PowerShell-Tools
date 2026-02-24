Get-ChildItem -Path "F:\PhotoSync\DCIM\Camera\文档" |
ForEach-Object -Parallel {
    $JpgFile = $_
    $ExifTool = "D:\Tools\ExifTool\exiftool.exe"
    $XmpData = & $ExifTool -X $JpgFile.FullName
    $XmpMiCamera = $XmpData | Select-String -Pattern "XMP-MiCamera"
    if (-not $XmpMiCamera) {
        #Move-Item -Path $JpgFile.FullName -Destination "F:\PhotoSync\DCIM\Camera\人像MissingMiCamera"
        Write-Host "$($JpgFile.Name) MOVED"
    }
} -ThrottleLimit 8