<#
 .Synopsis
 Beispiel f�r das Zusammenspiel von ConfirmImpact und ConfirmPreference
#>

function Remove-Number
{
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact="High")]
    param([Int[]]$BaseArray, [Int[]]$RemoveArray)
    foreach($z in $RemoveArray)
    {
        if ($PSCmdlet.ShouldProcess("Element $z l�schen?"))
        {
            $BaseArray = $BaseArray -ne $z
        }
    }
    $BaseArray
}

$z1 = 1..10
$z2 = 3,5,7

# Bei ConfirmPreference=High passiert nichts
$ConfirmPreference = "High"
Remove-Number $z1 $z2 # -Confirm:$False

# $ConfirmPreference = "Medium"
# Remove-Number $z1 $z2

