$fileName = ".gitconfig"
$targetPath = $pwd.Path + "\" + $fileName
$sourcePath = (Resolve-Path ~).Path + "\" + $fileName
if(-Not (Test-Path $sourcePath)){
	cmd /c mklink "$sourcePath" "$targetPath"
}else{
	$message = $targetPath + " already exists"
	echo $message
}