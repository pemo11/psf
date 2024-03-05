

$datetime = Get-Date

# Loop through each month in a year
for ($i = 1; $i -le 12; $i++) {
    # Set datetime to the first day of the month
    $datetime = Get-Date $i/1/$datetime.Year

    # Get the month name and print it
    $monthName = $datetime.ToString("MMMM")
    Write-Output $monthName
}
