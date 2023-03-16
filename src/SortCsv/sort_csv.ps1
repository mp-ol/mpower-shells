<# .SYNOPSIS #>
[CmdletBinding()]
param (
    [Parameter(Mandatory=$false)]
        [string]$SortField = "Size" ## field to sort by, defaults to Size the default field name for document sheet count field in Job Creation
    ,[Alias("D")][Switch]$Descending ## Whether to sort in the opposite order
    ,[Alias("N")][Switch]$Numeric ## Whether to sort numerically instead alphabetically
    ,[Parameter(Mandatory=$true)]
        [string]$In ## input CSV file, mandatory
    ,[Parameter(Mandatory=$true)]
        [string]$Out ## output CSV file, mandatory
)

# There is probably a more elegant way to create an "object that is a type", but this works.
$SortType=
if ($Numeric) {
    $myObj=42
    $myObj.GetType()
} else {
    $myObj="foo"
    $myObj.GetType()
}

Import-Csv $In | Sort-Object @{expression={$_.$SortField -as $SortType }} -Descending:$Descending | Export-Csv -NoTypeInformation $Out
