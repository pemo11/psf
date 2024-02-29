<#
 .Synopsis
 Ein Beispiel f�r den Pipeline-Parameter
#>

<#

# Ein sehr einfaches Beispiel f�r das generelle Verst�ndnis

(1..10) | Where-Object -PipelineVariable z { $_ % 2 -eq 1} | ForEach-Object {
    "$z wurde gepr�ft"
}

Get-Process -PipelineVariable p | Select-Object StartTime -First 3 | ForEach-Object {
    "Prozess: $($p.Name) startete um $($_.StartTime)"
}

#>

# Verzeichnisse ausgeben, auf die ein Benutzerkonto Vollzugriff besitzt,
# das kein Admin ist
Get-ChildItem -Path C:\ -ErrorAction Ignore -Directory -PipelineVariable dir |
  Get-ACL -ErrorAction Ignore | Select-Object -ExpandProperty Access |
  Where-Object { $_.FileSystemRights -eq "FullControl" -and  `
   $_.IdentityReference -notmatch "Administrator"} | 
    Select-Object -Property @{name="Benutzerkonto";expression={$_.IdentityReference}}, 
     @{n="Verzeichnis";e={$dir.FullName } }
