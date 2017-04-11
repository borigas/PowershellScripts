$targetPath = $PSScriptRoot
$sourcePath = $env:USERPROFILE + "\Documents\WindowsPowerShell\"
if(-Not (Test-Path $sourcePath)){
	cmd /c mklink /j "$sourcePath" "$targetPath"
}else{
	$message = $sourcePath + " already exists"
	echo $message
}