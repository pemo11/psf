<#
 .Synopsis
 Ein Beispiel f�r den OutVariable-Parameter
#>

Get-Process | Where-Object WS -gt 100MB -OutVariable Proz100MB |
 Stop-Process -WhatIf
  
$Proz100MB
