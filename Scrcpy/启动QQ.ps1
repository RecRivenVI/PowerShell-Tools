Set-Location -Path "D:\Tools\Scrcpy"
$IPandPort = Read-Host "ENTER IP AND PORT"
.\adb connect $IPandPort
.\scrcpy --serial=$IPandPort --new-display=1440x3200 --start-app=com.tencent.mobileqq --no-audio