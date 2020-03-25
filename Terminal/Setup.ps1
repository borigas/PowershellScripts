$targetPath = $PSScriptRoot + "\profiles.json"
$linkPath = $env:USERPROFILE + "\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\profiles.json"

$fileExists = Test-Path $linkPath
$makeLink = -Not $fileExists
if($fileExists){
	$file = Get-Item $linkPath
	if($file.Attributes -band [System.IO.FileAttributes]::ReparsePoint -eq 0){
		$makeLink = $true
	}else{
		echo "$linkPath already exists"
	}
}else{
	$makeLink = $true
}

if($makeLink){
	cmd /c mklink /h "$linkPath" "$targetPath"
}