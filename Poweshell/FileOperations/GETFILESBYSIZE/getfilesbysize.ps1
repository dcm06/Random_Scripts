$filepath = Read-Host "Folder Path: "
$filesize = Read-Host "File Size Filter: "
$files = get-ChildItem -path "$filepath"
$counter1 = 0
$counter2 = 0



Write-Host ""
Write-Host "Files Greater Than $filesize"
Write-Host "----------------------------"



foreach ($file in $files) {
	if($file.Length -gt $filesize){
		$counter1 = $counter1 + 1
		Write-Host "$file" -ForegroundColor Blue
	} 
}
if($counter1 -eq 0){
	Write-Host "None" -ForegroundColor Red
}
Write-Host "Total = $counter1 Files"


Write-Host ""
Write-Host ""


Write-Host "Files less Than $filesize"
Write-Host "----------------------------"
foreach ($file in $files) {	

	if($file.Length -lt $filesize){
		$counter2 = $counter2 + 1
		Write-Host "$file" -ForegroundColor Blue
	}
}
if($counter2 -eq 0){
	Write-Host "None" -ForegroundColor Red
}
Write-Host "Total = $counter2 Files"





	
	
