$WindowsISOsHash = Get-ChildItem -Path "G:\ISOs\Microsoft" -Filter *.iso |
ForEach-Object {
    [PSCustomObject]@{
        SHA256        = Get-FileHash -Path $_.FullName -Algorithm SHA256 | Select-Object -ExpandProperty Hash
        Path          = $_.FullName
        LastWriteTime = $_.LastWriteTime
    }
}

$WindowsISOsHash |
Sort-Object LastWriteTime |
Export-Csv -Path "$PSScriptRoot/WindowsISOsHash.csv" -Encoding UTF8 -NoTypeInformation
