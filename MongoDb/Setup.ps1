$fileName = ".mongorc.js"
$targetPath = $PSScriptRoot + "\" + $fileName
$sourcePath = (Resolve-Path ~).Path + "\" + $fileName
if(-Not (Test-Path $sourcePath)){
	cmd /c mklink "$sourcePath" "$targetPath"
}else{
	$message = $targetPath + " already exists"
	echo $message
}