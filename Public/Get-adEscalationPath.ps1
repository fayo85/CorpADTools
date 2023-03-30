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
