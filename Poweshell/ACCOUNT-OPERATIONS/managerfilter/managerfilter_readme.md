# MANAGER FILTER
### Description
This is a powershell script that accepts single letter options, reads user input and stores in variabless, performs AD Querries based on the options and inputs enterred, and finally displays the results in cmd or exports to CSV.








### PREVIEW
---

<img width="1046" height="482" alt="image" src="https://github.com/user-attachments/assets/4c1c117c-2ea9-43e4-bf3a-b991587bf9f7" />










### Main Variable
**$scriptops** -- This variable is used to make the main decision of what functions are run.
        
        $scriptops = Read-Host "Enter filter operation | Manager Only - (M), Title Only - (T), Both - (B), Find User's Manager - (U)"

### Defined functions

- `both` -- This function filters by manager, title and City in AD.





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
  
- `user` -- Filters by user first and last name.




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

- `usercsv` -- Filters by user, then exports the results to csv.



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

- `manager` -- Filters by manager and city.



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
- `Title` -- Filters by the user title and city




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

# Function Calls and Error Handling


### Error Message when **$scriptops** is empty
    ## If script operation variable is empty
    if ($scriptops -eq ""){
        throw "Option Cannot be empty"
    
    }




### Error message when **$scriptops** gets an invalid option
    ## If script operation variable is an invalid option
    if ($scriptops -ne "B" -and $scriptops -ne "M" -and $scriptops -ne "T" -and $scriptops -ne "U"){
        throw "Invalid Option"
    
    }




### Function running and error handling for each valid **$scriptops** option and other function options
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





<img width="1047" height="980" alt="Screenshot 2026-06-20 165138" src="https://github.com/user-attachments/assets/a481f7ce-a279-4e36-b4b8-4a654732b174" />
