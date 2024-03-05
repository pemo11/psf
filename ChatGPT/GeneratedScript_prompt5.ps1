

# This Powershell script deletes all files in the current directory that have not been used for more than 90 days

# Get current date
$currentDate = Get-Date

# Loop through all files in current directory
Get-ChildItem | ForEach-Object {
  # Calculate last accessed date for each file
  $lastAccessed = $_.LastAccessTime
  # Calculate time difference in days
  $timeDifference = ($currentDate - $lastAccessed).
