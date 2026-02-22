Get-ChildItem -Path "D:\GitHub\PowerShell-Tools\Test-Photos\assets" -Filter *.jpg |
ForEach-Object -Parallel {
    $ExifTool = "D:\Tools\ExifTool\exiftool.exe"
    $JpgFile = $_
    $DateTimeOriginal = & $ExifTool -DateTimeOriginal -s3 $JpgFile.FullName
    $XmpData = & $ExifTool -X $JpgFile.FullName
    $XmpMicroVideo = $XmpData | Select-String -Pattern "MicroVideo"
    if ($DateTimeOriginal) {
        $FormattedDateTimeOriginal = [DateTime]::ParseExact($DateTimeOriginal, "yyyy:MM:dd HH:mm:ss", $null)
        if ($XmpMicroVideo) {
            $NewJpgFileName = $FormattedDateTimeOriginal.ToString("'MVIMG_'yyyyMMdd_HHmmss'.jpg'")
            if ($NewJpgFileName -ne $JpgFile.Name) {
                Rename-Item -Path $JpgFile.FullName -NewName $NewJpgFileName
                Write-Host RENAMED $JpgFile.Name TO $NewJpgFileName 
            }
            else {
                Write-Host $JpgFile.Name SAME AS $NewJpgFileName, NOT RENAMED
            }
        }
        else {
            $NewJpgFileName = $FormattedDateTimeOriginal.ToString("'IMG_'yyyyMMdd_HHmmss'.jpg'")
            if ($NewJpgFileName -ne $JpgFile.Name) {
                Rename-Item -Path $JpgFile.FullName -NewName $NewJpgFileName
                Write-Host RENAMED $JpgFile.Name TO $NewJpgFileName 
            }
            else {
                Write-Host $JpgFile.Name SAME AS $NewJpgFileName, NOT RENAMED
            }
        }
    }
    else {
        Write-Host $JpgFile.Name TIMESTAMP NOT FOUND
    }
} -ThrottleLimit 8
