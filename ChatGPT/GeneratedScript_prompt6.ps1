 tags

<#
.Synopsis
Deletes all files in the current directory that have not been used for more than 90 days.

.Description
This Powershell script checks the current directory for any files that have not been used for 90 days or more and deletes them. This can be useful for cleaning up old or unused files that are taking up space.

#>

#Get the current date
$currentDate = Get-Date

#Get the list of files in the current directory
$files = Get-ChildItem -File

#Loop through each file
foreach($file in $files) {

    #Get the last used date of the file
    $lastUsedDate = $file.LastWriteTime

    #Calculate the number of days since the file was last used
    $daysSinceLastUsed = ($currentDate - $lastUsedDate).Days

    #Check if the file has not been used for 90 days
    if($daysSinceLastUsed -gt 90) {

        #Delete the file
        Remove-Item $file.Fullname
    }
}

Write-Host "All files older than 90 days have been deleted." 
