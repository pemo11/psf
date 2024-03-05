<#
 .SYNOPSIS
 Ein Skript per ChatGPT generieren, um das ChatGPT-Modul zu installieren.
 .NOTES
#>

$ConfigPath = Join-Path -Path $PSScriptRoot -ChildPath "Config.psd1"
$ConfigData = Import-PowerShellDataFile -Path $ConfigPath

$apiKey = $ConfigData.secretKey

$prompt = "Please write a script that outputs all month names in German"

# $OpenAIUri = "https://api.openai.com/v1/engines/gpt-4/completions"
$OpenAIUri = "https://api.openai.com/v1/completions"

$requestBody = @{
    model = "gpt-3.5-turbo-instruct"
}

$jsonBody = $RequestBody | ConvertTo-Json

$header =@{ Authorization = "Bearer $apiKey" }

$response = Invoke-RestMethod -Uri $OpenAIUri -Method Post -Headers $header -Body $jsonBody -ContentType "application/json"

# Nur "Müll", da es noch keinen Prompt gibt, der das gewünschte Ergebnis liefert
$generatedScript = $response.choices[0].text
$generatedScript

