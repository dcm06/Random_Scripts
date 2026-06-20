# GET FILE BY SIZE
### Description
This is a script that accepts user input and stores it into a variable. It does this using the `Read-Host` Cmdlet

### Defined Variables

- `$filepath = Read-Host "Folder Path: "` -- This reads input and stores it in the filepath variable
- `$filesize = Read-Host "File Size Filter: "` -- This reads input and stores it in the filesize filter variable
- `$files = get-ChildItem -path "$filepath"` -- This Retrieved the files in the path specified and stores it in the files variable
- `$counter1 = 0` -- 1st counter variable
- `$counter2 = 0` -- 2nd counter Variable

### Loop initialization
#### Files Greater than the specified file size

`foreach ($file in $files) {`

`	if($file.Length -gt $filesize){`
`		$counter1 = $counter1 + 1`
`		Write-Host "$file" -ForegroundColor Blue`
`	} `
`}`
`if($counter1 -eq 0){`
`	Write-Host "None" -ForegroundColor Red`
`}`
`Write-Host "Total = $counter1 Files"`
