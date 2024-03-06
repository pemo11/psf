<#
 .SYNOPSIS
 Aktualisieren eines  Knotens in einer XML-Datei
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

# Select the node to update with XPath
$ServerId = "S_1009"
$serverNodeToUpdate = $xmlDoc.SelectSingleNode("//$($nsPrefix):server[@id='$ServerId']", $nsManager)

# Update the node by selecting the child node
$serverNodeToUpdate.SelectSingleNode("$($nsPrefix):size", $nsManager).InnerText = "Special123"

# Save the modified XML back to the file
try
{
    $xmlFilePath = Join-Path -Path $PSScriptRoot -ChildPath "ServerDaten_Modified.Xml"  
    $xmlDoc.Save($xmlFilePath)
    Write-Host "Modified XML file saved to $xmlFilePath"
} catch {
    Write-Host "Error: $_"
}
