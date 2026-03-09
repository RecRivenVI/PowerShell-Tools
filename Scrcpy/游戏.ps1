Set-Location -Path "D:\Tools\Scrcpy"
$PackageNames = Get-Content -Path "$PSScriptRoot\包名.txt" | Where-Object { $_ -notmatch '^#' }
$IPandPort = Read-Host "ENTER IP AND PORT"
.\adb connect $IPandPort
#$GAME = Read-Host "ENTER PACKAGE NAME"
$PackageNames | 
ForEach-Object {
    Start-Process .\scrcpy.exe -ArgumentList "--serial=$IPandPort --new-display=2560x1440 --start-app=$_ --no-audio"
    Start-Sleep -Milliseconds 2000
}