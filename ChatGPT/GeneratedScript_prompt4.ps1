.


# Set the current working directory
$directory = Get-Location

# Get all files in the current directory and subdirectories
$files = Get-ChildItem $directory -Recurse

# Loop through each file
foreach ($file in $files) {
    # Get the last accessed date
    $lastAccessedDate = $file.LastAccessTime

    # Calculate the number of days since last access
    $daysSinceLastAccess = ((Get-Date)
