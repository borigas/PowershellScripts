$fileName = ".gitconfig"
$targetPath = $pwd.Path
$sourcePath = (Resolve-Path ~).Path + "\Documents\WindowsPowerShell\"
if(-Not (Test-Path $sourcePath)){
	cmd /c mklink /j "$sourcePath" "$targetPath"
}else{
	$message = $targetPath + " already exists"
	echo $message
}