<#
 .SYNOPSIS
    This script creates a new PowerShell cmdlet.
 .NOTES


#>

$DllPath = Join-Path -Path $PSScriptRoot -ChildPath "PoshQuoteCmdlet.dll"
$CsPath = Join-Path -Path $PSScriptRoot -ChildPath "PoshQuoteCmdlet.cs"
Add-Type -Path $CsPath -OutputType Library -OutputAssembly $DllPath -PassThru

Import-Module $DllPath -Force -Verbose