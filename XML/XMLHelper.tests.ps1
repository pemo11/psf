<#
 .SYNOPSIS
#>

#requires -modules @{ModuleName='Pester';ModuleVersion='5.2.0'}

BeforeAll {
    $psm1Path = Join-Path -Path $PSScriptRoot -ChildPath 'XMLHelper.psm1'
    Import-Module -Name $psm1Path -Force
}

Describe "Tests für das Anlegen eines XML-Dokuments" {
    it "legt ein XDokument ohne root element an" {
        $d = New-XDocument
        $d | Should -BeOfType [System.Xml.Linq.XDocument]
        $d.ToString() | Should -BeNullOrEmpty
    }
    it "legt ein XDokument mit root-Element an" {
        $d = New-XDocument -RootElementName "Root"
        $d.Root.Name| Should -Be "Root"
    }
}

Describe "Tests für das Hinzufügen eines Knotens" {
    it "legt ein XML-Dokument mit einem Kindknoten an" {
        $d = New-XDocument -RootElementName "Root"
        Add-XElement -XNode $d.Root -name "Child" -value "Value"
        $d.Root.Elements().Count | Should -Be 1
    }

    
    it "legt ein XML-Dokument mit drei Kindknoten an" {
        $d = New-XDocument -RootElementName "Root"
        Add-XElement -XNode $d.Root -name "Child1" -value "Value"
        Add-XElement -XNode $d.Root -name "Child2" -value "Value"
        Add-XElement -XNode $d.Root -name "Child3" -value "Value"
        $d.Root.Elements().Count | Should -Be 3
    }
}