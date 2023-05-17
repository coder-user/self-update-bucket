$Script = {
    Remove-ItemProperty Registry::'HKEY_CURRENT_USER\Software\Scooter Software\Beyond Compare 4' 'CacheID' -ErrorAction Ignore
}
$Action = New-ScheduledTaskAction -Execute 'PowerShell.exe' -Argument "-NonInteractive -NoLogo -NoProfile -WindowStyle Hidden -Command $Script"
$Trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Days 7)
$Principal = New-ScheduledTaskPrincipal -UserID "$env:USERNAME" -LogonType S4U
Register-ScheduledTask -TaskName 'reset-beyondcompare-trial' -Action $Action -Trigger $Trigger -Principal $Principal -Force
Start-ScheduledTask -TaskName 'reset-beyondcompare-trial'
