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
$newServerNode.AppendChild($newSizeNode)

$newManufactureNode = $xml.CreateElement("ps", "Manufacturer", $ns)
$newManufactureNode.InnerText = "Supermicro"
$newServerNode.AppendChild($newManufactureNode)

$newCostNode = $xml.CreateElement("ps", "Cost", $ns)
$newCostNode.InnerText = 9.1234
$newServerNode.AppendChild($newCostNode)

# Append the new node to the root element
$xml.DocumentElement.AppendChild($newServerNode)

# Save the modified XML back to the file
try
{
    $xmlFilePath = Join-Path -Path $PSScriptRoot -ChildPath "ServerDaten_Modified.Xml"  
    $xml.Save($xmlFilePath)
    Write-Host "Modified XML file saved to $xmlFilePath"
} catch {
    Write-Host "Error: $_"
}
