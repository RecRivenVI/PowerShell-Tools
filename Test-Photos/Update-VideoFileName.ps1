Get-ChildItem -Path "C:\Users\RavenYin\Downloads\1" -File -Recurse |
ForEach-Object -Parallel {
    $ExifTool = "D:\Tools\ExifTool\exiftool.exe"
    $Mp4File = $_
    $MediaCreateDate = & $ExifTool -QuickTime:CreateDate -s3 $Mp4File.FullName
    $MediaDuration = & $ExifTool -QuickTime:Duration -s3 $Mp4File.FullName
    $XmpData = & $ExifTool -X $Mp4File.FullName
    $Xmpdby1 = $XmpData | Select-String -Pattern "dby1" -Quiet
    if ($MediaDuration -match "^[0-9]{1,2}[.][0-9]{1,2}[ ]s$") {
        $raw = $MediaDuration -replace " s$",""
        $seconds = [double]$raw
        $FormattedMediaDuration = [TimeSpan]::FromSeconds($seconds)
    }
    elseif ($MediaDuration -match "^[0-9]{1}[:][0-9]{2}[:][0-9]{2}$") {
        $FormattedMediaDuration = [TimeSpan]::ParseExact($MediaDuration, "h\:mm\:ss", $null)
    }
    else{
        Write-Host $Mp4File.Name DURATION ERROR
    }
    if ($MediaCreateDate) {
        $FormattedMediaCreateDateRaw = [DateTime]::ParseExact($MediaCreateDate, "yyyy:MM:dd HH:mm:ss", $null)
        $FormattedMediaCreateDateRaw1 = $FormattedMediaCreateDateRaw.Add(-$FormattedMediaDuration)
        $FormattedMediaCreateDate = $FormattedMediaCreateDateRaw1.AddHours(8)
        if ($Xmpdby1) {
            $NewMp4FileName = $FormattedMediaCreateDate.ToString("'VID_'yyyyMMdd_HHmmss'_DOLBY.mp4'")
            if ($NewMp4FileName -ne $Mp4File.Name) {
                Rename-Item -Path $Mp4File.FullName -NewName $NewMp4FileName
                Write-Host RENAMED $Mp4File.Name TO $NewMp4FileName 
            }
            else {
                Write-Host $Mp4File.Name SAME AS $NewMp4FileName, NOT RENAMED
            }
        }
        else {
            $NewMp4FileName = $FormattedMediaCreateDate.ToString("'VID_'yyyyMMdd_HHmmss'.mp4'")
            if ($NewMp4FileName -ne $Mp4File.Name) {
                Rename-Item -Path $Mp4File.FullName -NewName $NewMp4FileName
                Write-Host RENAMED $Mp4File.Name TO $NewMp4FileName 
            }
            else {
                Write-Host $Mp4File.Name SAME AS $NewMp4FileName, NOT RENAMED
            }
        }
    }
    else {
        Write-Host $Mp4File.Name TIMESTAMP NOT FOUND
    }
} -ThrottleLimit 16
