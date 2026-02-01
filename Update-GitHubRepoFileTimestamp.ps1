Get-ChildItem -Path . -Recurse |
ForEach-Object -Parallel {
    $GitObject = $_
    $LatestTime = git log --max-count=1 --format=%ad --date=format:'%Y-%m-%d %H:%M:%S' $GitObject.FullName
    if ($LatestTime) {
        $LatestTime = [datetime]"$LatestTime"
    }
    if ($LatestTime) {
        $GitObject.LastWriteTime = $LatestTime
    }
    Write-Host $GitObject.Name $GitObject.LastWriteTime
} -ThrottleLimit 32
