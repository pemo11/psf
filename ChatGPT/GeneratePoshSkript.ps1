<#
 .SYNOPSIS
 Ein Skript per ChatGPT generieren, um das ChatGPT-Modul zu installieren.
 .NOTES
#>

$ConfigPath = Join-Path -Path $PSScriptRoot -ChildPath "Config.psd1"
$ConfigData = Import-PowerShellDataFile -Path $ConfigPath

$env:OpenAIKey = $ConfigData.secretKey

$RequestBody = @{
    prompt = "list of planets only names as xml"
    model = "gpt-3.5-turbo-1106"
    temperature = 1
    Stop = "."
}

$Header =@{ Authorization = "Bearer $($env:OpenAIKey) " }
$RequestBody=$RequestBody | ConvertTo-Json

$OpenAIUri = "https://api.openai.com/v1/completions"

$RestMethodParameter = @{
    Method = "Post"
    Uri = $OpenAIUri
    body = $RequestBody
    Headers = $Header
    ContentType = "application/json"
}

$Result = Invoke-RestMethod @RestMethodParameter
$Result # .choices[0].text

