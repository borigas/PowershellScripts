$targetPath = $PSScriptRoot + "\profiles.json"
$linkPath = $env:USERPROFILE + "\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\profiles.json"

$fileExists = Test-Path $linkPath
$makeLink = -Not $fileExists
if($fileExists){
	$file = Get-Item $linkPath
	if(-not $file.LinkType){
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