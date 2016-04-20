$fileName = ".gitconfig"
$targetPath = $PSScriptRoot + "\" + $fileName
$sourcePath = $env:USERPROFILE + "\" + $fileName
if(-Not (Test-Path $sourcePath)){
	cmd /c mklink "$sourcePath" "$targetPath"
}else{
	$message = $targetPath + " already exists"
	echo $message
}