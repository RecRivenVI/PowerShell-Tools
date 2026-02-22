Get-ChildItem -Path "D:\GitHub\PowerShell-Tools\Test-Photos\assets" -Filter *.jpg |
ForEach-Object -Parallel {
    $JpgFile = $_
    $ExifTool = "D:\Tools\ExifTool\exiftool.exe"
    $XmpData = & $ExifTool -X $JpgFile.FullName
    $XmpMiCamera = $XmpData | Select-String -Pattern "XMP-MiCamera"
    if (-not $XmpMiCamera){
        Move-Item -Path $JpgFile.FullName -Destination "D:\GitHub\PowerShell-Tools\Test-Photos\assetsNoMiCamera"
    }
} -ThrottleLimit 8