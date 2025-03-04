$size_limit = "40gb"
$file_suffix = '*.adi', '*.bak', '*.vhd'
# The above fields are required

Set-Location -Path $PSScriptRoot

function Get-AllBackups {
    $file_list = Get-ChildItem $file_suffix -File
    Write-Host "All backups:"
    $file_list  | Format-Table | Out-String | Write-Host
    Return $file_list
}

function Find-LastFullBackup {
    Param($FileList)
    $last_full_backup = ($FileList | Where-Object Length -gt $size_limit | Sort-Object LastWriteTime | Select-Object -Last 1)
    Write-Host "Last full backup:"
    $last_full_backup | Format-Table | Out-String | Write-Host
    Return $last_full_backup
}

function Remove-OldBackups {
    Param($FileList,$LastFullBackup)
    $old_backups = ($FileList | Where-Object LastWriteTime -lt $LastFullBackup.LastWriteTime)
    Write-Host "Removing old Backups:"
    $old_backups | Format-Table | Out-String | Write-Host
    $old_backups | Remove-Item
}

$file_list = Get-AllBackups
$last_full_backup = Find-LastFullBackup $file_list
Remove-OldBackups $file_list $last_full_backup