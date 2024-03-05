<#
 .SYNOPSIS
 Ein Skript per ChatGPT generieren, um das ChatGPT-Modul zu installieren.
 .NOTES
#>

$ConfigPath = Join-Path -Path $PSScriptRoot -ChildPath "Config.psd1"
$ConfigData = Import-PowerShellDataFile -Path $ConfigPath

$apiKey = $ConfigData.secretKey

$prompt1 = "Please write a Powershell script that outputs all month names in German"
$prompt2 = "Please write a Powershell script that generates all month names from a datetime object"
$prompt3 = "Please write a Powershell script that generates all month names from a datetime object in German"

$prompt4 = "Please write a Powershell script that deletes all files in the current directory if they have not used for more than 90 days"

$prompt5 = "Please write a Powershell script that deletes all files in the current directory if they have not used for more than 90 days and use a comment at the top of the script"
# Nicht so einfach, den Kommentar zu generieren...
$prompt6 = "Please write a Powershell script that deletes all files in the current directory if they have not used for more than 90 days and add a multiline comment at the top of the script with a .synopsis and .description"
$prompt7 = "Please write a Powershell script that deletes all files in the current directory if they have not used for more than 90 days, use the whatif parameter and add a multiline comment at the top of the script with a .synopsis and .description"
$prompt8 = "Please write a Powershell script that deletes all users in a active directory that have not logged in for more than 90 days"

# Dieser Prompt wird verwendet  
$CurrentPromptName = "prompt8"
# Den Prompt über den Namen der Variablen holen
$CurrentPrompt = (Get-Variable -Name $CurrentPromptName).Value

# $OpenAIUri = "https://api.openai.com/v1/engines/gpt-4/completions"
$OpenAIUri = "https://api.openai.com/v1/completions"

# je niedriger der temperature wert, desto konservativer die Antworten
$requestBody = @{
    "model" = "gpt-3.5-turbo-instruct"
    "prompt" = $CurrentPrompt
    "max_tokens" = 1024
    "temperature" = 0.2
}

$jsonBody = $RequestBody | ConvertTo-Json

$header =@{ Authorization = "Bearer $apiKey" }

$startTime = Get-Date
$response = Invoke-RestMethod -Uri $OpenAIUri -Method Post -Headers $header -Body $jsonBody -ContentType "application/json"

$duration = (Get-Date) - $startTime

$generatedScript = $response.choices[0].text
$totalTokens = $response.usage.total_tokens
$OutputPath = Join-Path -Path $PSScriptRoot -ChildPath "GeneratedScript_$($CurrentPromptName).ps1"
$generatedScript | Out-File -FilePath $OutputPath

"Auftrag ausgeführt in $($duration.TotalSeconds)s mit $totalTokens tokens. Ergebnis in $OutputPath"
