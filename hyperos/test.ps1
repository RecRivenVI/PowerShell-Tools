$ExistedTgzs = Get-ChildItem -Path "D:\tgzs" -File
$ExistedNames = @($ExistedTgzs.Name)
$DeviceList = Get-Content -Path "$PSScriptRoot\devices.txt"

$DeviceList |
ForEach-Object -Parallel { 
    function Test-RomStatus {
        if ($using:ExistedNames -contains ($json.LatestFullRom.filename -replace " ", "")) {
            Write-Host ("已存在 | $($json.LatestFullRom.version) | $($json.LatestFullRom.device)" -replace "V816", "OS1")
        }
        else {
            Write-Host ("可更新 | $($json.LatestFullRom.version) | $($json.LatestFullRom.device) |" -replace "V816", "OS1")(("https://bkt-sgp-miui-ota-update-alisgp.oss-ap-southeast-1.aliyuncs.com/$($json.LatestFullRom.version)/$($json.LatestFullRom.filename)" -replace " ", "") -replace "V816", "OS1")
        }
    }
    if ($_ -eq "clover") {
        $json = (Invoke-WebRequest -Uri "https://update.intl.miui.com/updates/miota-fullrom.php?d=$_&b=X&r=cn") | ConvertFrom-Json
        Test-RomStatus
    }
    else {
        $json = (Invoke-WebRequest -Uri "https://update.intl.miui.com/updates/miota-fullrom.php?d=$_&b=F&r=cn") | ConvertFrom-Json
        Test-RomStatus
    }
} -ThrottleLimit 8
