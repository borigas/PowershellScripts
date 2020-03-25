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

$shellExtensionKey = "Registry::HKEY_CLASSES_ROOT\Directory\Background\shell\Terminal"
if(-Not (Test-Path $shellExtensionKey))
{
	$iconPath = "$PSScriptRoot\terminal.ico"
	$exePath = "$($env:LOCALAPPDATA)\Microsoft\WindowsApps\wt.exe"
	$commandKey = "$shellExtensionKey\command"

	New-Item $shellExtensionKey
	Set-ItemProperty $shellExtensionKey -Name "(Default)" -Value "Windows Terminal Here"
	Set-ItemProperty $shellExtensionKey -Name "Icon" -Value "$iconPath"
	
	New-Item $commandKey
	Set-ItemProperty $commandKey -Name "(Default)" -Value ($exePath + ' -d "%V\."')
}