# GET FILE BY SIZE
### Description
This is a script that accepts user input and stores it into a variable. It does this using the `Read-Host` Cmdlet

- `$filepath = Read-Host "Folder Path: "`
- `$filesize = Read-Host "File Size Filter: "`
- `$files = get-ChildItem -path "$filepath"`
- `$counter1 = 0`
- `$counter2 = 0`
