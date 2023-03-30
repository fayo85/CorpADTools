function Get-adUserManager{
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