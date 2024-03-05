

<#
.SYNOPSIS
This script deletes files in the current directory that have not been used for more than 90 days.

.DESCRIPTION
This Powershell script uses the Get-ChildItem cmdlet to retrieve all files in the current directory and checks their LastWriteTime property. If the file has not been used for more than 90 days, it will be deleted. The script uses the -WhatIf parameter to show a preview of the files that will be deleted without actually deleting them.
#>

# Get all files in the current directory
$files = Get-ChildItem

# Loop through each file
foreach ($file in $files) {
    # Check if the file has not been used for more than 90 days
    if ($file.LastWriteTime -lt (Get-Date).AddDays(-90)) {
        # Delete the file and show a preview using the -WhatIf parameter
        Remove-Item $file.FullName -WhatIf
    }
}
