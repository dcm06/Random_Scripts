$devices = Read-Host "Enter Device name(s)/IP(s) {###,###,...}"
$numbercount = Read-Host "Enter Ping count number"

$devicesplit = $devices -split "," | Foreach-Object {$_.Trim()}

foreach($device in $devicesplit) {
	Write-Host ""
	Write-Host "Testing Connection to $device"
	Write-Host "-----------------------------"
	Test-Connection $device -count $numbercount
}
