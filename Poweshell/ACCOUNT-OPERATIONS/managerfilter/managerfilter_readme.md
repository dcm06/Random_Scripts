# GET FILE BY SIZE
### Description
This is a script that accepts user input and stores it into a variable. It does this using the `Read-Host` Cmdlet

### Defined functions

- `both` -- This function filters by manager, title and City in AD.
- `user` -- Filters by user first and last name.
- `usercsv` -- Filters by user, then exports the results to csv.
- `manager` -- Filters by manager and city.
- `Title` -- Filters by the user title and city

### Code Block explanations
`## If script operation variable is empty`
`if ($scriptops -eq ""){`
`    throw "Option Cannot be empty"`
``
`}`

`## If script operation variable is an invalid option`
`if ($scriptops -ne "B" -and $scriptops -ne "M" -and $scriptops -ne "T" -and $scriptops -ne "U"){`
`    throw "Invalid Option"`

`}`
#### Files Greater than the specified file size
### Loop initialization
#### Files Greater than the specified file size

`foreach ($file in $files) {` -- Foreach loop initialized, each value of $files is placed into $file one at a time



`	if($file.Length -gt $filesize){` -- If condition - Runs the code block if the current file has a size greater than the specified filesize filter



`		$counter1 = $counter1 + 1` -- Counter increased by 1 for each file that meets the criteria



`		Write-Host "$file" -ForegroundColor Blue` -- Displays the name of the file that meets the criteria on the screen in Blue.



`	} `



`}`



`if($counter1 -eq 0){`



`	Write-Host "None" -ForegroundColor Red`  -- If counter 1 is still 0, Display **None** in Red. After the loop is completed



`}`



`Write-Host "Total = $counter1 Files"` -- Displays the total number of files that met the criteria after the loop is complete





#### Files Less than the specified file size

`foreach ($file in $files) {`



` 	if($file.Length -lt $filesize){` -- If condition - Runs the code block if the current file has a size less than the specified filesize filter



` 		$counter2 = $counter2 + 1`



` 		Write-Host "$file" -ForegroundColor Blue`



` 	}`



` }`



` if($counter2 -eq 0){`



` 	Write-Host "None" -ForegroundColor Red`




` }`



` Write-Host "Total = $counter2 Files"`




---
### PREVIEW
---

<img width="1122" height="830" alt="Screenshot 2026-06-20 164659" src="https://github.com/user-attachments/assets/c7b67c25-b566-45c1-81b1-196fe229d324" />


<img width="1047" height="980" alt="Screenshot 2026-06-20 165138" src="https://github.com/user-attachments/assets/a481f7ce-a279-4e36-b4b8-4a654732b174" />
