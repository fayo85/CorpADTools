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