Import-Module ActiveDirectory


# Retrieve a list of all groups
$allgroups = Get-Content -Path .\list.txt


#initialise array
$array = @()



foreach($group in $allgroups) {
    # Retrieve Groups with their description
    $groupwithdescription = $group | Get-ADGroup -Properties * | select SamAccountName, Description
    

    # Sorting data
    $samname = $groupwithdescription.SamAccountName
    $description = $groupwithdescription.Description
    $membercount = (Get-ADGroup $group -Properties *).Member.Count

    #Creating array with headers and per group data
    $headers =  "" | select SamAccountName,Description,Count
    $headers.SamAccountName = $samname
    $headers.Description = $description
    $headers.Count = $membercount

    #Adding data to array
    $array += $headers

    }


$array | export-CSV ".\group-counts.csv" -NoTypeInformation

