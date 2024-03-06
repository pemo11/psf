<#
 .SYNOPSIS
 Anhängen eines Knotens an eine XML-Datei per [Xml]
 .NOTES
 Namespaces spielen jetzt eine Rolle
#>

$XmlPath = Join-Path -Path $PSScriptRoot -ChildPath ServerDaten.Xml
$Xml = [Xml](Get-Content -Path $XmlPath)

# Create a new XML node with namespace
$ns = $xml.DocumentElement.NamespaceURI
$newServerNode = $xml.CreateElement("ps", "server", $ns)
$newServerNode.SetAttribute("id", "S_1099")
$newSizeNode = $xml.CreateElement("ps", "size", $ns)
$newSizeNode.InnerText = "Special"
[void]$newServerNode.AppendChild($newSizeNode)

$newManufactureNode = $xml.CreateElement("ps", "manufacturer", $ns)
# Aufruf ohne einen Namespace-Präfix
# $newManufactureNode = $xml.CreateElement("manufacturer")
$newManufactureNode.InnerText = "Supermicro"
[void]$newServerNode.AppendChild($newManufactureNode)

$newCostNode = $xml.CreateElement("ps", "cost", $ns)
$newCostNode.InnerText = 9.1234
[void]$newServerNode.AppendChild($newCostNode)

# Append the new node to the root element
[void]$xml.DocumentElement.AppendChild($newServerNode)

# Save the modified XML back to the file
try
{
    $xmlFilePath = Join-Path -Path $PSScriptRoot -ChildPath "ServerDaten_Modified.Xml"  
    $xml.Save($xmlFilePath)
    Write-Host "Modified XML file saved to $xmlFilePath"
} catch {
    Write-Host "Error: $_"
}
