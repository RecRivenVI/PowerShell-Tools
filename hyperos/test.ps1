$ExistedTgzs = Get-ChildItem -Path "G:\tgz线刷包" -File
$DeviceList = Get-Content -Path "$PSScriptRoot\devices.txt"

$DeviceList |
ForEach-Object -Parallel { 
    $json = (Invoke-WebRequest -Uri "https://update.intl.miui.com/updates/miota-fullrom.php?d=$_&b=F&r=cn") | ConvertFrom-Json
    if ($using:ExistedTgzs.Name -contains ($json.LatestFullRom.filename -replace " ","")) {
        Write-Host "$($json.LatestFullRom.version)已存在"
    } else {
        Write-Host ("https://bkt-sgp-miui-ota-update-alisgp.oss-ap-southeast-1.aliyuncs.com/$($json.LatestFullRom.version)/$($json.LatestFullRom.filename)" -replace " ","")
    }
} -ThrottleLimit 32