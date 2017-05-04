$folder = "C:\Users\Jamie\OneDrive\"
$folderSize = ( Get-ChildItem $folder -Recurse -Force | Measure-Object -Property Length -Sum ).Sum
If ( $folderSize -lt 1KB ) { $folderSizeOutput = "$("{0:N2}" -f $folderSize) B" }
ElseIf ( $folderSize -lt 1MB ) { $folderSizeOutput = "$("{0:N2}" -f ($folderSize / 1KB)) KB" }
ElseIf ( $folderSize -lt 1GB ) { $folderSizeOutput = "$("{0:N2}" -f ($folderSize / 1MB)) MB" }
ElseIf ( $folderSize -lt 1TB ) { $folderSizeOutput = "$("{0:N2}" -f ($folderSize / 1GB)) GB" }
ElseIf ( $folderSize -lt 1PB ) { $folderSizeOutput = "$("{0:N2}" -f ($folderSize / 1TB)) TB" }
ElseIf ( $folderSize -ge 1PB ) { $folderSizeOutput = "$("{0:N2}" -f ($folderSize / 1PB)) PB" }
Write-Output $folderSizeOutput