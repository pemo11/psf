<#
 .Synopsis
 Ein Hallo, Welt-Cmdlet in C#
 .Notes
 Durch Ausführen wird eine Dll-Datei erstellt, die per Import-Module als Binärmodul geladen wird
 Das Cmdlet heißt Get-PCInfo
 Setzt System.Management.Automation.dll im aktuellen Verzeichnis voraus
#>

$CSCode = @'
using System;
using System.Management.Automation;
using System.Management;

[Cmdlet(VerbsCommon.Get, "PCInfo")]
public class InfoCmdlet : PSCmdlet
{
    [Parameter]
    public SwitchParameter Show {get; set;}
    [Parameter]
    public SwitchParameter TestError { get;set;}

    protected override void ProcessRecord()
    {
        if (TestError)
        {
            // Soll einen Terminating Error "simulieren"
            SystemException ex = new SystemException("Kein echter Fehler, nur ein Test");
            ErrorRecord er = new ErrorRecord(ex, "TerminatingError-Simulation", ErrorCategory.InvalidOperation, null);
            ThrowTerminatingError(er);
        }
        else
        {
            WriteObject(String.Format("All systems ready at {0:HH:mm}", DateTime.Now));
        }
    }
}

'@

$DllPath = Join-Path -Path $PSScriptRoot -ChildPath "HelloPoshCmdlet.dll"
# Umsetzen des C#-Codes in eine Dll-Datei
# ReferencedAssemblies ist nicht nötig, da System.Management.Automation.dll im aktuellen Verzeichnis liegt
Add-Type -TypeDefinition $CSCode -ReferencedAssemblies System.Management.Automation -OutputAssembly $DllPath -OutputType Library -PassThru
# Benennung des Name-Parameters ist nicht ganz optimal
Import-Module -Name $DllPath