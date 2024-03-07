<#
 .Synopsis
 Logging mit der Nlog-Dll
 .Notes
 Funktioniert grundsätzlich, aber in VS Code hängt die Ausführung bei jedem 2ten oder 3ten Start
#>

using namespace NLog

$AssPfad = Join-Path -Path $PSScriptRoot -ChildPath "../Assemblies/Nlog.dll"
Add-Type -Path $AssPfad

$NlogConfig = @'
<nlog>
<targets>
  <target name="console" type="Console" layout="${shortdate} ${time} ==> ${message}" encoding="UTF-8" />
  <target
    name="file"
    type="file"
    layout="${date:format=yyyy-MM-dd HH\:mm\:ss} ==> ${message}" 
    fileName="${specialfolder:folder=MyDocuments}/PoshLog.log"
    keepFileOpen="false"
    encoding="UTF-8"
   />
</targets>
<rules>
  <logger name="*" minlevel="Debug" writeTo="console,file" />
</rules>
</nlog>
'@

$NlogConfigPath = Join-Path -Path $PSScriptRoot -ChildPath "Nlog.config"
$NlogConfig | Set-Content -Path $NlogConfigPath -Encoding Default

[LogManager]::Configuration = [Config.XmlLoggingConfiguration]::new($NlogConfigPath, $True)

# Variante A - gesteuert über eine Config-Datei
$LogMan =  [LogManager]::GetCurrentClassLogger()
$InfoMessage = ("*** Info: Logging something at {0:HH:mm} ***" -f (Get-Date))
$LogMan.Info($InfoMessage)

$InfoMessage = ("*** Debug: Logging something at {0:HH:mm} ***" -f (Get-Date))
$LogMan.Debug($InfoMessage)

# Variante B - Konfiguration über Befehle festlegen
$LogConfig = [Config.LoggingConfiguration]::new()
$ColConsoleTarget = [Targets.ColoredConsoleTarget]::new()
$ColConsoleTarget.Layout = '${date:format=dd-MM-yyyy HH\:mm\:ss} => ${message}'
$LogConfig.AddTarget("console", $ColConsoleTarget)
$FileTarget = [Targets.FileTarget]::new()
$FileTarget.Layout = '${date:format=dd-MM-yyyy HH\:mm\:ss} => ${message}'
$FileTarget.FileName = Join-Path -Path $PSScriptRoot -ChildPath "NLogTest.log"

# Keine Debug-Meldungen, da LogLevel "hochgesetzt" wird
$Rule1 = [Config.LoggingRule]::new("*", [LogLevel]::Info, $ColConsoleTarget)
$LogConfig.LoggingRules.Add($Rule1)

$Rule2 = [Config.LoggingRule]::new("*", [LogLevel]::Info, $FileTarget)
$LogConfig.LoggingRules.Add($Rule2)

[LogManager]::Configuration = $LogConfig
$LogMan = [LogManager]::GetLogger("Test")

$InfoMessage = ("*** Info: Logging more at {0:HH:mm} ***" -f (Get-Date))
$LogMan.Info($InfoMessage)

$InfoMessage = ("*** Debug: Logging more at {0:HH:mm} ***" -f (Get-Date))
$LogMan.Debug($InfoMessage)

