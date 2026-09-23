
Write-Host -foregroundcolor red @"
██████╗  ██████╗███╗   ███╗
██╔══██╗██╔════╝████╗ ████║
██║  ██║██║     ██╔████╔██║
██║  ██║██║     ██║╚██╔╝██║
██████╔╝╚██████╗██║ ╚═╝ ██║
╚═════╝  ╚═════╝╚═╝     ╚═╝

     [ D-C-M SCRIPTS]
"@

Write-Host ""
Write-Host "--------------------------------------"
Write-Host -foregroundcolor black -backgroundcolor white "EMPLOYEE MANAGER & TITLE FILTER SEARCH SCRIPT"
Write-Host "--------------------------------------"
Write-Host ""


$scriptops = Read-Host "Enter filter operation | Manager Only - (M), Title Only - (T), Both - (B), Find User's Manager - (U)"


## FILTER BY MANAGER AND TITLE 
function both {
    $manfirst = Read-Host "Enter Manager first Name"
    $manlast = Read-Host "Enter Manager last Name"
    $city = Read-Host "Enter City"
    $usertitle = Read-Host "Enter Job Title"
    $select = "Name","Title","SamAccountName"

    if ($city -eq ""){
        $city = "*"
        $select = "Name","Title","SamAccountName","City"
    }

    if ($usertitle -eq ""){
        $usertitle = "*"
    }

    Get-ADUser -Filter * `
    -properties Manager,Title,City -ErrorAction Stop |
    Where-Object {
        $_.Manager -like "CN=$manlast\, $manfirst*" -and
        $_.Title -like "*$usertitle*" -and
        $_.City -like "*$city*"
    } |
    Select-Object -property $select
}


function user {
    $userfirst = Read-Host "Enter User first Name"
    $userlast = Read-Host "Enter User last Name"
    $select = "Manager","SamAccountName","Title", "City"


    Get-ADUser -Filter * `
    -properties Name,Manager,Title,City -ErrorAction Stop |
    Where-Object {
        $_.Name -like "$userlast, $userfirst"
    } |
    Select-Object -property $select
}


function usercsv {
    $path = (Read-Host "Enter CSV file Path - [No quotes]").ToString()
    $select = "Manager","SamAccountName","Title","Name"
    $count = get-content $path | convertfrom-csv | select-object -property "id" 

    
    for ($counter=1; $counter -le $count.count; $counter++){
        $name = get-content $path | convertfrom-csv | where-object -property "id" -eq $counter

        $userfirst = $name."first name"
        $userlast = $name."last name"


        Get-ADUser -Filter * `
        -properties Name,Manager,Title,City -ErrorAction Stop |
        Where-Object {
            $_.Name -like "$userlast, $userfirst"
        } |
        Select-Object -property $select
    }

}
## FILTER BY MANAGER ONLY 
function manager {
    $manfirst = Read-Host "Enter Manager first Name"
    $manlast = Read-Host "Enter Manager last Name"
    $city = Read-Host "Enter City (Press Enter to search all)"
    $select = "Name","Title","SamAccountName"

    if ($city -eq ""){
        $city = "*"
        $select = "Name","Title","SamAccountName","City"
    }
    Get-ADUser -Filter * `
    -properties Manager,Title,City -ErrorAction Stop |
    Where-Object {
        $_.Manager -like "CN=$manlast\, $manfirst*" -and
        $_.City -like "*$city*"
    } |
    Select-Object -property $select
}

## FILTER BY TITLE ONLY 
function Title {
    $usertitle = Read-Host "Enter Job Title"
    $city = Read-Host "Enter City (Press Enter to search all)"
    $select = "Name","Title","SamAccountName", "Manager"

    if ($city -eq ""){
        $city = "*"
        $select = "Name","Title","SamAccountName","City","Manager"
    }

    if ($usertitle -eq ""){
        $usertitle = "*"
    }

    Get-ADUser -Filter * `
    -Properties Manager,Title,City -ErrorAction Stop |
    Where-Object {
        $_.Title -like "*$usertitle*" -and
        $_.City -like "*$city*"
    } |
    Select-Object -property $select
}


## If script operation variable is empty
if ($scriptops -eq ""){
    throw "Option Cannot be empty"

}

## If script operation variable is an invalid option
if ($scriptops -ne "B" -and $scriptops -ne "M" -and $scriptops -ne "T" -and $scriptops -ne "U"){
    throw "Invalid Option"

}

#### If script operation variable is not empty
if ($scriptops -ne ""){
    ## If option B is chosen
    if ($scriptops -eq "B"){
        try{
            both
        } catch {
            Write-Host "An Error Occured" -ForegroundColor Red
            }
    }


    ## If option M is chosen
    if ($scriptops -eq "M"){
        try{
            manager
        } catch {
            Write-Host "An Error Occured" -ForegroundColor Red
            }
    }


    ## If option T is chosen
    if ($scriptops -eq "T"){
        try{
            Title
        } catch {
            Write-Host "An Error Occured" -ForegroundColor Red
            }
    }

    if ($scriptops -eq "U"){
        $ops = Read-Host "Select Filter Operation | Import CSV - (c), Single User - (s) [Enter for singe User]"

        if ($ops -ne "C" -and $ops -ne "S" -and $ops -ne ""){
            throw "Invalid Option"

        }
        if ($ops -eq "S" -or $ops -eq "" ){
            try{
                user
            } catch {
                Write-Host "An Error Occured" -ForegroundColor Red
                }
            }
        if ($ops -eq "c"){
            try{
                usercsv
            } catch {
                Write-Host "An Error Occured" -ForegroundColor Red
                }
            }
    }




}
