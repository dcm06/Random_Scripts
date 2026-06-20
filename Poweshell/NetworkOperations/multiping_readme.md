# MULTIPING
### Description
This is a script that accepts user input(Device Name, IP or Domains) and stores it into a variable. It does this using the `Read-Host` Cmdlet. Then strips the input by **,** and saves all input in an array. It also strips all spaces 

### Defined Variables

- `$devices = Read-Host "Enter Device name(s)/IP(s) {###,###,...}"` -- This reads multiple inputs separated by commas, and saves them in the **devices** variable
- `$numbercount = Read-Host "Enter Ping count number"` -- This reads input and stores it in the **numbercount** variable, for ping count.
- `$devicesplit = $devices -split "," | Foreach-Object {$_.Trim()}` -- This splits the input values in **devices**, then trims each of them, removing potential unwanted characters, then saves it to **devicesplit**

### Loop initialization
#### Files Greater than the specified file size

`foreach($device in $devicesplit) { ` -- Foreach loop initialized, each value of $devicesplit is placed into $device one at a time

    `Write-Host ""`



    `Write-Host "Testing Connection to $device"`


  
    `Write-Host "-----------------------------"`


  
    `Test-Connection $device -count $numbercount` -- Uses Powershell **Test-Connection** cmdlet to test the connection between the current device and the device specified in $devices, then $numbercount value used for the number of connections for each device,IP, or Domain



    `}`



---
### PREVIEW
---

<img width="1378" height="872" alt="Screenshot 2026-06-20 153506" src="https://github.com/user-attachments/assets/34fff673-f974-409d-ba9e-c7c3cd53a7b8" />


