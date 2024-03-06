<# 
 .Synopsis
 Beispiel für eine Typ-Formatierung
#>

# Ziel: Der Typ Server nachträglich soll eine Laufzeit-Eigenschaft erhalten
enum ServerStatus
{
    Running
    Stopped
}

# Typdefinition Server
class Server
{
    [String]$Name
    [ServerStatus]$Status
    [DateTime]$Startzeit

    Server([String]$Name)
    {
        $this.Name = $Name
        $this.Startzeit = Get-Date
    }
}

$FormatXml = @'
<Configuration>
  <ViewDefinitions>
    <View>
        <Name>Servertype</Name>
        <ViewSelectedBy>
            <TypeName>Server</TypeName>
        </ViewSelectedBy>
        <TableControl>
            <TableHeaders>
                <TableColumnHeader>
                    <Label>Name</Label>
                    <Width>20</Width>
                </TableColumnHeader>
                <TableColumnHeader>
                    <Label>Status</Label>
                    <Width>20</Width>
                </TableColumnHeader>
                <TableColumnHeader>
                    <Label>Starttime</Label>
                    <Width>20</Width>
                </TableColumnHeader>
            </TableHeaders>
            <TableRowEntries>
                <TableRowEntry>
                    <TableColumnItems>
                        <TableColumnItem>
                            <PropertyName>Name</PropertyName>
                        </TableColumnItem>
                        <TableColumnItem>
                            <PropertyName>Status</PropertyName>
                        </TableColumnItem>
                        <TableColumnItem>
                            <ScriptBlock>
                            <!-- "`e[38;5;199m$($_.Startzeit)`e[0m" -->
                            "$([Char]27)[38;5;199m$($_.Startzeit)$([Char]27)[0m"                            
                            </ScriptBlock>
                        </TableColumnItem>
                    </TableColumnItems>
                </TableRowEntry>
            </TableRowEntries>
        </TableControl>
    </View>
   </ViewDefinitions>
</Configuration>
'@

# Erweiterung muss ps1xml sein
$FormatXmlPath = Join-Path -Path $PSScriptRoot -ChildPath ServerFormat.ps1xml
$FormatXml | Set-Content -Path $FormatXmlPath

Update-FormatData -AppendPath $FormatXmlPath

$S1 = [Server]::new("Server123")
$S2 = [Server]::new("Server456")
$S3 = [Server]::new("Server789")
$ServerListe = @($S1, $S2, $S3)

Get-FormatData -TypeName Server
$ServerListe | Format-Table -View Servertype

