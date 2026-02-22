Get-ChildItem -Path "C:\Users\RavenYin\OneDrive\图片\Touhou Wallpapers" -File |
ForEach-Object -Parallel {
    $file = $_
    $md5 = (Get-FileHash -LiteralPath $file.FullName -Algorithm MD5).Hash.ToLower()
    if ($md5 -ceq $file.BaseName) {
        Write-Host "$($file.Name) name not changed"
    }
    else {
        Write-Host "$($file.Name) name need change into $($md5 + $file.Extension)"
        #Rename-Item -LiteralPath $file.FullName -NewName ($md5 + $file.Extension)
    }
} -ThrottleLimit 32