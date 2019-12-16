$server_ou = (Get-ADOrganizationalUnit -Filter 'Name -like "Servers"').DistinguishedName 
$computers = Get-ADComputer -SearchBase $server_ou -Filter *


ForEach($item in $computers)
{
    Write-Output "Connecting to: $item"
   $session =  New-PSSession $item
   $result = Invoke-Command -Session $remotesession `
   { Start-Process "\\$((Get-WmiObject win32_computersystem).Domain)\SYSVOL\$((Get-WmiObject win32_computersystem).Domain)\scripts\SEP.exe"  -Wait } 
    Write-Output $result
}