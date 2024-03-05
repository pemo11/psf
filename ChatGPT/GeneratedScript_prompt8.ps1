

# Set the number of days for inactive users
$daysInactive = 90

# Get the current date
$currentDate = Get-Date

# Get a list of all users in the Active Directory
$users = Get-ADUser -Filter * -Properties LastLogonDate

# Loop through each user
foreach ($user in $users) {

    # Check if the user has a LastLogonDate
    if ($user.LastLogonDate) {

        # Calculate the number of days since the user last logged in
        $daysSinceLastLogon = ($currentDate - $user.LastLogonDate).Days

        # Check if the user has not logged in for more than 90 days
        if ($daysSinceLastLogon -gt $daysInactive) {

            # Delete the user from the Active Directory
            Remove-ADUser -Identity $user -Confirm:$false

            # Output a message to the console
            Write-Host "User $($user.Name) has been deleted from the Active Directory."
        }
    }
}

# Output a message to the console
Write-Host "All inactive users have been deleted from the Active Directory."
