<#
 .SYNOPSIS
 Convert an object to XML and back
#>

class Person
{
    [string]$Name
    [int]$Age
    [string]$City

    Person([string]$Name, [int]$Age, [string]$City)
    {
        $this.Name = $Name
        $this.Age = $Age
        $this.City = $City
    }
}

# Create some objects of the Person class
$person1 = [Person]::new("Tom", 25, "New York")
$person2 = [Person]::new("John", 35, "Chicago")
$person3 = [Person]::new("Andy", 45, "Los Angeles")

$personList = @( $person1, $person2, $person3 )

# Convert the object to XML - einfach, aber die Elementnamen sind vorgegeben
$xml = [System.Management.Automation.PSSerializer]::Serialize($personList)
$xml

$XmlPath = Join-Path -Path $PSScriptRoot -ChildPath "Personen.xml"

# Eine eigene XML-Konvertierung, die auf den Namen der Properties basiert
{
    "<Personen>"
    $personList.ForEach{
        " <$($_.GetType().Name)>"
        $_.psobject.Properties.ForEach{
            "  <$($_.Name)>$($_.Value)</$($_.Name)>"
        }
        " </$($_.GetType().Name)>"
    }
    "</Personen>" 
}.Invoke() | Out-File $XmlPath

