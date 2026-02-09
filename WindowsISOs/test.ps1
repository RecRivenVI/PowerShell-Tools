$Path = "G:\ISOs\Microsoft\zh-cn_windows_11_consumer_editions_version_25h2_x64_dvd_0549fc93.iso"
$image = Mount-DiskImage $Path
$locate = (Get-Volume -DiskImage $image).DriveLetter
if (Test-Path "$locate`:\sources\install.wim") {
    $null = 7z x "$locate`:\sources\install.wim" "[1].xml" -oD:\uupdump\
}
elseif (Test-Path "$locate`:\sources\install.esd") {
    $null = 7z x "$locate`:\sources\install.esd" "[1].xml" -oD:\uupdump\
}
else {
    Write-Host "WRONG ISO!"
    $null = Dismount-DiskImage $Path
    exit
}
if (-not (Test-Path -LiteralPath "D:\uupdump\[1].xml")) {
    Write-Host "METADATA NOT EXIST!"
    $null = Dismount-DiskImage $Path
    exit
}
[xml]$xml = Get-Content -LiteralPath "D:\uupdump\[1].xml"
$MAJOR = $xml.WIM.IMAGE.WINDOWS.VERSION.MAJOR | Select-Object -First 1
$MINOR = $xml.WIM.IMAGE.WINDOWS.VERSION.MINOR | Select-Object -First 1
$BUILD = $xml.WIM.IMAGE.WINDOWS.VERSION.BUILD | Select-Object -First 1
$SPBUILD = $xml.WIM.IMAGE.WINDOWS.VERSION.SPBUILD | Select-Object -First 1
$SPLEVEL = $xml.WIM.IMAGE.WINDOWS.VERSION.SPLEVEL | Select-Object -First 1
$BRANCH = $xml.WIM.IMAGE.WINDOWS.VERSION.BRANCH | Select-Object -First 1
Write-Host "Windows 11 $MAJOR.$MINOR.$BUILD.$SPBUILD.$SPLEVEL.$BRANCH $Path"
Remove-Item -LiteralPath "D:\uupdump\[1].xml"
$null = Dismount-DiskImage $Path