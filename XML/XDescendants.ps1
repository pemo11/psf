<#
 .SYNOPSIS
XML-Verarbeitung mit System.Linq.Xml-Klassen
#>

using namespace System.Xml.Linq

$xmlPath = Join-Path -Path $PSScriptRoot -ChildPath "ServerDaten_OhneNs.xml"
$d = [XDocument]::Load($xmlPath)
$server = $d.Descendants().Where{ $_.Name -eq "server" 
 -and $_.FirstAttribute.Value -eq "S_1001"}
$server[0].Add([XElement]::new("neu", "neuer Wert"))
$xmlPath = Join-Path -Path $PSScriptRoot -ChildPath "ServerDaten_OhneNs_neu.xml"
$d.Save($xmlPath)
