if((Test-Path "C:\Program Files (x86)\Symantec\Symantec Endpoint Protection") -or (Test-Path "C:\Program Files\Symantec\Symantec Endpoint Protection"))
{
    Write-host "SEP Installed" -ForegroundColor Green
}
Else{
   Start-Process "\\$((Get-WmiObject win32_computersystem).Domain)\SYSVOL\$((Get-WmiObject win32_computersystem).Domain)\scripts\SEP.exe" 
}