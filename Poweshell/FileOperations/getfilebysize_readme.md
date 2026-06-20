# GET FILE BY SIZE
### Description
This is a script that accepts user input and stores it into a variable. It does this using the `Read-Host` Cmdlet

### Defined Variables

- `$filepath = Read-Host "Folder Path: "` -- This reads input and stores it in the **filepath** variable
- `$filesize = Read-Host "File Size Filter: "` -- This reads input and stores it in the **filesize** filter variable
- `$files = get-ChildItem -path "$filepath"` -- This retrieves the files in the path specified and stores it in the **files** variable
- `$counter1 = 0` -- 1st counter variable
- `$counter2 = 0` -- 2nd counter Variable

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
