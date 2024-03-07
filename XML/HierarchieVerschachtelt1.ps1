<#
 .Synopsis
 Durchsuchen einer Xml-Datei mit einer verschachtelten Hierarchie
 .Notes
 Eine list-Element kann entry- und list-Elemente enthalten, dadurch kann sich eine beliebig verschachtelte Hierarchie ergeben
#>

using namespace System.Xml.Linq

$XmlText = @'
<pm:adressbook xmlns:pm="urn:codeclass" >
 <pm:list id="1" caption="Liste 1" createDate="06-03-2020 10:00">
  <pm:entry>
   <name>Liste 1 - Name 1</name>
  </pm:entry>
  <pm:list id="2" caption="Liste 2" createDate="06-03-2020 9:20">
    <pm:entry>
     <name>Liste 2 - Name 1</name>
    </pm:entry>
    <pm:entry>
     <name>Liste 2 - Name 2</name>
    </pm:entry>
    <pm:entry>
     <name>Liste 3 - Name 3</name>
    </pm:entry>
    <pm:list id="3" caption="Liste 3" createDate="06-03-2020 11:10">
      <pm:entry>
       <name>Liste 3 - Name 1</name>
      </pm:entry>
      <pm:entry>
        <name>Liste 3 - Name 2</name>
     </pm:entry>
   </pm:list>
  </pm:list>
  <pm:entry>
   <name>Liste 1  - Name 2</name>
  </pm:entry>
 </pm:list>
 <pm:list id="4" caption="Liste 4" createDate="06-03-2020 10:00">
  <pm:entry>
   <name>Liste 4 - Name 1</name>
  </pm:entry>
  <pm:entry>
  <name>Liste 4 - Name 2</name>
  </pm:entry>
  <pm:entry>
   <listref>1</listref>
  </pm:entry>
 </pm:list>
</pm:adressbook>
'@

$Xns = [XNamespace]::get("urn:codeclass")

$XAdrBook = [XDocument]::Parse($XmlText)

# Hole das erste Element - Liste 1
$XAdrBook.Root.Element($Xns + "list").ToString()
$XAdrBook.Root.Element($Xns + "list").Attribute("caption").Value

# Holt alle Listen der obersten Ebene
@($XAdrBook.Root.Elements($Xns + "list")).Count
$XAdrBook.Root.Elements($Xns + "list").ForEach{$_.Attribute("caption").Value}

# Holt alle Listen
$XAdrBook.Root.Descendants($Xns + "list").ForEach{$_.Attribute("caption").Value}
