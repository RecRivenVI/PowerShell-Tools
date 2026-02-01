$env:HTTP_PROXY = "http://127.0.0.1:7897"
$env:HTTPS_PROXY = "http://127.0.0.1:7897"
gh release list -R PrismLauncher/PrismLauncher --limit 128 --json tagName |
ConvertFrom-Json |
ForEach-Object -Parallel {
    gh release download $_.tagName `
        -R PrismLauncher/PrismLauncher `
        -p 'PrismLauncher-Windows-MSVC-Portable*' `
        --skip-existing
} -ThrottleLimit 32
