Get-ChildItem -Path "C:\Users\RavenYin\OneDrive\图片\动图" -File -Filter *.gif |
ForEach-Object -Parallel {
    $file = $_
    $fs = [System.IO.File]::OpenRead($file.FullName)
    $buffer = New-Object byte[] 6
    $fs.Read($buffer, 0, 6) | Out-Null
    $fs.Close()
    $magic = -join ($buffer | ForEach-Object { [char]$_ })

    if ($magic -eq "GIF87a" -or $magic -eq "GIF89a") {
        #Write-Host "[OK] $($file.Name)  魔数: $magic"
    }
    else {
        Write-Host "[ERR] $($file.Name)  魔数异常: $magic"
    }
} -ThrottleLimit 32
