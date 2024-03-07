<#
 .SYNOPSIS
 Verschiedene Hilfsfunktionen für XML-Dokumente
#>

using namespace System.Xml.Linq

<#
 .SYNOPSIS
 Erstellt ein neues XML-Dokument
#>
function New-XDocument
{
    param([String]$RootElementName)
    if ($RootElementName)
    {
        [XDocument]::new([XElement]::new([XName]::Get($RootElementName)))
    }
    else
    {
        [XDocument]::new()
    }
}

<#
 .SYNOPSIS
  Erstellt ein neues XElement
#>
function Add-XElement
{
    param([XElement]$XNode, [String]$name, [String]$value)
    $XNode.Add([XElement]::new([XName]::Get($name), $value))
}
