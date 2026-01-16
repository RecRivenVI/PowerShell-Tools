Get-ChildItem -Path . -Filter *.zip |
ForEach-Object -Parallel {
    $ZipFile = $_
    $LatestTime = 
    7z l $ZipFile.FullName |
    Where-Object {
        $_ -match '^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2} (?!D)\S{5}'
    } |
    ForEach-Object {
        if ($_ -match '^(\d{4}-\d{2}-\d{2}) (\d{2}:\d{2}:\d{2})') {
            [datetime]"$($matches[1]) $($matches[2])"
        }
    } |
    Sort-Object -Descending |
    Select-Object -First 1
    if ($LatestTime) {
        $ZipFile.LastWriteTime = $LatestTime
    }
    Write-Host $ZipFile.Name $ZipFile.LastWriteTime
} -ThrottleLimit 32
