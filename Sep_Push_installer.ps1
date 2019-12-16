$server_ou = (Get-ADOrganizationalUnit -Filter 'Name -like "Servers"').DistinguishedName 
$computers = Get-ADComputer -SearchBase $server_ou -Filter *
$server_Name = ''



ForEach($item in $computers.name)
{
    Write-Output "Connecting to: $item"
   
    Invoke-Command -ScriptBlock  { mkdir c:\sep} -ComputerName $item
    $session = New-PSSession $item

    # To avoid having to use Credssp and fall foul of the double hop issue
    copy-item \\$server_Name\SEP\sep.exe c:\sep -ToSession $session

    $result = Invoke-Command -ScriptBlock  {
        
        if(!(Test-Path "C:\Program Files (x86)\Symantec\Symantec Endpoint Protection"))
        {
            Start-Process "c:\sep\sep.exe" -Wait
            Write-Host "installing SEP"
        }
        
        if(Test-Path 'c:\sep' )
        {Remove-Item c:\sep -Recurse}
       
    } -ComputerName $item
    $result
    Remove-PSSession $session
}

