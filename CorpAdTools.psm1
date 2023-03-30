#sad corporate life 
function get-admanager{
    [CmdletBinding()]

    Param(
    [string] $userID
    
)
    try {$manager= Get-ADUser $userID -Properties Manager -ErrorAction SilentlyContinue|Select-Object -ExpandProperty Manager
    if(![string]::IsNullOrEmpty($manager))
    {$manager=($manager.split(',')[0]).replace('CN=','')}
    return $manager
    }
    catch {}
}

function Get-adEscalationPath 
{
    param(
        [string] $userid
    )
    $level=0

$numbers=@{
    1 = '1st';
    2 = '2nd';
    3='3rd';
    4='4th';
    5='5th';
    6='6th';
    7='7th';
    8='8th';
    9='9th';
    10='10th'
}
    $escalationPath=@()
    
    $obj=""|select-object userid
    $obj.userid=$userid
    while (![string]::IsNullOrEmpty((get-admanager -userID $userid )))
    {
        
        $level++
        $obj|Add-Member -MemberType NoteProperty -Name ($numbers[$level] + "LevelManager" ) -Value (get-admanager -userID $userid)
        $escalationPath+=$obj
        $userid=get-admanager -userID $userid
    }
    return $obj
}

function Get-adSponsoredAccounts
{
param(
    [CmdletBinding()]
    [string] $userID 
    
)
try {
  $directReports=  Get-aduser -Identity $userID -Properties DirectReports |Select-Object -ExpandProperty DirectReports
  if($null -ne $directReports )
  {
    
    $directReports=$directReports|ForEach-Object {$_.split(',')[0].replace('CN=','')}
  }
}
catch {
    Write-Output "error handling to be added here "
}
$directReports
}

Export-ModuleMember *