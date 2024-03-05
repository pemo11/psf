<#
 .SYNOPSIS
 Entfernen eines  Knotens in einer XML-Datei per Select-Xml
 .NOTES
 Namespaces werden aus dem Dokument übernommen
#>

# Load the XML document
$XmlPath = Join-Path -Path $PSScriptRoot -ChildPath ServerDaten.Xml
$xmlDoc = [Xml](Get-Content -Path $XmlPath)

# Define the namespace prefix
$nsPrefix = "ps"
$nsUri = "poshkurs#1234"

# Create a namespace manager
$nsManager = [System.Xml.XmlNamespaceManager]::new($xmlDoc.NameTable)
$nsManager.AddNamespace($nsPrefix, $nsUri)

# Select the node to remove with XPath
$ServerId = "S_1009"
$nodeToRemove = $xmlDoc.SelectSingleNode("//$($namespacePrefix):server[@id='$ServerId']", $nsManager)

# Remove the node
$nodeToRemove.ParentNode.RemoveChild($nodeToRemove)

# Save the modified XML back to the file
try
{
    $xmlFilePath = Join-Path -Path $PSScriptRoot -ChildPath "ServerDaten_Modified.Xml"  
    $xml.Save($xmlFilePath)
    Write-Host "Modified XML file saved to $xmlFilePath"
} catch {
    Write-Host "Error: $_"
}
