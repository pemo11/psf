<#
 .SYNOPSIS
 Mehrere Knoten in einer XML-Datei per Select-Xml auswählen
#>

$XmlPath = Join-Path -Path $PSScriptRoot -ChildPath ServerDaten.Xml
$Xml = [Xml](Get-Content -Path $XmlPath)

# Define the namespace prefix
$nsPrefix = "ps"
$nsUri = "poshkurs#1234"
# Create a namespace manager
$nsManager = [System.Xml.XmlNamespaceManager]::new($xmlDoc.NameTable)
$nsManager.AddNamespace($nsPrefix, $nsUri)

# Select the nodes with XPath
$nodes = $xmlDoc.SelectNodes("//$($namespacePrefix):server", $nsManager)
$nodes.ForEach{
    $_.id
    $_.manufacturer
}

# Select the nodes of a specific manufacturer 
Write-Host "Select the nodes of specific manufacturer"
$manufacturer = "Lenovo"
$nodes = $xmlDoc.SelectNodes("//$($namespacePrefix):server/$($namespacePrefix):manufacturer[text()='$manufacturer']", $nsManager)
$nodes.Count
$nodes.ForEach{
    $_
}

# Frage: Wie wird z.B. der Wert des Knotens "size" oder "cost" ermittelt?