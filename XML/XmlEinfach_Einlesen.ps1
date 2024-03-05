<#
 .SYNOPSIS
 Einfaches Einlesen einer XML-Datei per [Xml]
 .NOTES
 Namespaces müssen nicht beachtet werden
#>

$XmlPath = Join-Path -Path $PSScriptRoot -ChildPath ServerDaten.Xml

$Xml = [Xml](Get-Content -Path $XmlPath)

# Auflisten aller server-knoten
$Xml.serverdaten.server

# Auflisten aller server-Knoten, die von Dell sind
$Xml.serverdaten.server.Where{$_.manufacturer -eq 'Dell'}

# Lokalisieren eines bestimmten Servers - Attribute werden als Properties behandelt
$Xml.serverdaten.server | Where-Object {$_.id -eq 'S_1001'}


