<#
 .SYNOPSIS
XML-Verarbeitung mit System.Linq.Xml-Klassen
#>

using namespace System.Xml.Linq

class Server
{
    [String]$Id
    [String]$Size
    Server([String]$Id, [String]$Size)
    {
        $this.Id = $Id
        $this.Size = $Size
    }
}

$xmlPath = Join-Path -Path $PSScriptRoot -ChildPath "ServerDaten_OhneNs.xml"
$d = [XDocument]::Load($xmlPath)
$ServerListe = @()
$d.Descendants().Where{$_.Name -eq "server"}.ForEach{
    $ServerListe += [Server]::new($_.FirstAttribute.Value, 
     $_.Element("size").Value)   
}
$ServerListe
