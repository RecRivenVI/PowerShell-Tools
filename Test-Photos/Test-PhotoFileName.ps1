$RenameStatue = Get-ChildItem -Path "D:\GitHub\PowerShell-Tools\Test-Photos\assets" -Filter *.jpg |
ForEach-Object -Parallel {
    $JpgFile = $_
    $ExifTool = "D:\Tools\ExifTool\exiftool.exe"
    $DateTimeOriginal = & $ExifTool -DateTimeOriginal -s3 $JpgFile.FullName
    $XmpData = & $ExifTool -X $JpgFile.FullName
    $XmpMicroVideo = $XmpData | Select-String -Pattern "MicroVideo"
    if ($DateTimeOriginal) {
        $FormattedDateTimeOriginal = [DateTime]::ParseExact($DateTimeOriginal, "yyyy:MM:dd HH:mm:ss", $null)
        if ($XmpMicroVideo) {
            $NewJpgFileName = $FormattedDateTimeOriginal.ToString("'MVIMG_'yyyyMMdd_HHmmss'.jpg'")
            if ($NewJpgFileName -ne $JpgFile.Name) {
                <# Rename-Item -Path $JpgFile.FullName -NewName $NewJpgFileName #>
                <# Write-Host RENAMED $JpgFile.Name TO $NewJpgFileName #> 
                [PSCustomObject]@{
                    Name    = $JpgFile.Name
                    NewName = $NewJpgFileName
                    Statue  = "RENAMED"
                }
            }
            else {
                <# Write-Host $JpgFile.Name SAME AS $NewJpgFileName, NOT RENAMED #>
                [PSCustomObject]@{
                    Name    = $JpgFile.Name
                    NewName = $NewJpgFileName
                    Statue  = "SAME"
                }
            }
        }
        else {
            $NewJpgFileName = $FormattedDateTimeOriginal.ToString("'IMG_'yyyyMMdd_HHmmss'.jpg'")
            if ($NewJpgFileName -ne $JpgFile.Name) {
                <# Rename-Item -Path $JpgFile.FullName -NewName $NewJpgFileName #>
                <# Write-Host RENAMED $JpgFile.Name TO $NewJpgFileName #> 
                [PSCustomObject]@{
                    Name    = $JpgFile.Name
                    NewName = $NewJpgFileName
                    Statue  = "RENAMED"
                }
            }
            else {
                <# Write-Host $JpgFile.Name SAME AS $NewJpgFileName, NOT RENAMED #>
                [PSCustomObject]@{
                    Name    = $JpgFile.Name
                    NewName = $NewJpgFileName
                    Statue  = "SAME"
                }
            }
        }
    }
    else {
        <# Write-Host $JpgFile.Name TIMESTAMP NOT FOUND #>
        [PSCustomObject]@{
            Name    = $JpgFile.Name
            NewName = "NONE"
            Statue  = "TIMESTAMP NOT FOUND"
        }
    }
} -ThrottleLimit 32

$RenameStatue |
Sort-Object Name |
Export-Csv -Path "$PSScriptRoot/Test-PhotoFileName_Result.csv" -Encoding UTF8 -NoTypeInformation
