$size_limit = "40gb"
$file_suffix = '*.adi', '*.bak', '*.vhd'
# The above fields are required

Set-Location -Path $PSScriptRoot

function Get-AllBackups {
    Param($FileSuffix)
    $file_list = Get-ChildItem $FileSuffix -File
    Write-Host "All backups:"
    $file_list  | Format-Table | Out-String | Write-Host
    Return $file_list
}

function Find-LastFullBackup {
    Param($FileList,$SizeLimit)
    $last_full_backup = ($FileList | Where-Object Length -gt $SizeLimit | Sort-Object LastWriteTime | Select-Object -Last 1)
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

$file_list = Get-AllBackups $file_suffix
$last_full_backup = Find-LastFullBackup $file_list $size_limit
Remove-OldBackups $file_list $last_full_backup