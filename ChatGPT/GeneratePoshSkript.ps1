<#
 .SYNOPSIS
 Ein Skript per ChatGPT generieren, um das ChatGPT-Modul zu installieren.
 .NOTES
#>

$ConfigPath = Join-Path -Path $PSScriptRoot -ChildPath "Config.psd1"
$ConfigData = Import-PowerShellDataFile -Path $ConfigPath

$env:OpenAIKey = $ConfigData.secretKey

$RequestBody = @{
    model = "gpt-3.5-turbo-1106"
    temperature = 0.7
    messages = @(
        @{role="user";content="Say hello to the world!"}
        )
}

$Header =@{ Authorization = "Bearer $($env:OpenAIKey) " }
$RequestBody=$RequestBody | ConvertTo-Json

$OpenAIUri = "https://api.openai.com/v1/chat/completions"

$RestMethodParameter = @{
    Method = "Post"
    Uri = $OpenAIUri
    body = $RequestBody
    Headers = $Header
    ContentType = "application/json"
}

$Result = Invoke-RestMethod @RestMethodParameter
$Result # .choices[0].text

