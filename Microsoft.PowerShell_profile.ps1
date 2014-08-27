#### Functions Used to Load VS Command Prompt #####

function Get-Batchfile ($file) {
	$cmd = "`"$file`" & set"
	cmd /c $cmd | Foreach-Object {
		$p, $v = $_.split('=')
		Set-Item -path env:$p -value $v
	}
}

###### Function Used to Load VS Command Prompt #####
function VsVars32()
{
	#$version = "9.0"
	#$version = "10.0"
	#$key = "HKLM:SOFTWARE\Microsoft\VisualStudio\" + $version
	#$key = "HKLM:SOFTWARE\Wow6432Node\Microsoft\VisualStudio\" + $version
	#$VsKey = Get-ItemProperty $key
	#$VsInstallPath = [System.IO.Path]::GetDirectoryName($VsKey.InstallDir)
	#$VsToolsDir = [System.IO.Path]::GetDirectoryName($VsInstallPath)
	#$VsToolsDir = [System.IO.Path]::Combine($VsToolsDir, "Tools")
	
	$version = "11.0"
	$vs110comntools = (Get-ChildItem env:VS110COMNTOOLS).Value    
	$batchFile = [System.IO.Path]::Combine($vs110comntools, "vsvars32.bat")
	Get-Batchfile $batchFile
	[System.Console]::Title = "Powershell w/ Visual Studio " + $version
}

###### Function Used to Set Background to Light Blue If not Admin ######

function AmIAdmin()
{
	$wid=[System.Security.Principal.WindowsIdentity]::GetCurrent()
	$prp=new-object System.Security.Principal.WindowsPrincipal($wid)
	$adm=[System.Security.Principal.WindowsBuiltInRole]::Administrator
	$IsAdmin=$prp.IsInRole($adm)
	$title = [System.Console]::Title
	if (!$IsAdmin)
	{ 
		$title = $title + " (Non-Administrator)"
		(Get-Host).UI.RawUI.Backgroundcolor="Black"
	}
	else
	{
		$title = $title + " (Administrator)"
		(Get-Host).UI.RawUI.Backgroundcolor="Black"
	}
	[System.Console]::Title = $title
    return $IsAdmin
}

###### Run Functions on Startup ######
VsVars32

$IsAdmin = AmIAdmin

###### Set Aliases ######
set-alias notepad "C:\Program Files (x86)\Notepad++\notepad++.exe"

$hosts = $env:SystemRoot + "\system32\drivers\etc\hosts"
function edit-hostfile { 
	notepad $hosts 
}
set-alias hosts edit-hostfile
function Get-ProfileDirectory {
	$profileFile = Get-ChildItem $profile
	$profileFile.DirectoryName
}
set-alias profileDir Get-ProfileDirectory

#Setup git and PoshGit
. (Resolve-Path "$env:LOCALAPPDATA\GitHub\shell.ps1")
. $env:github_posh_git\profile.example.ps1

$global:GitPromptSettings.WorkingForegroundColor    = [ConsoleColor]::Red 
$global:GitPromptSettings.UntrackedForegroundColor  = [ConsoleColor]::Red
$global:GitPromptSettings.IndexForegroundColor  = [ConsoleColor]::Green

if(!$IsAdmin){
    Start-SshAgent
}

function gitstatus { git status }
set-alias gs gitstatus
function gitpull { git pull }
set-alias pu gitpull
function stash-pull{
	git stash
	git pull
	git stash pop
}
function publishBranch{
    $fullBranchName = git symbolic-ref HEAD
    $shortBranchName = $fullBranchName.Substring($fullBranchName.LastIndexOf("/")+1)
    git push --set-upstream origin $shortBranchName
}
set-alias gpub publishBranch

function mongo {
    . "C:\workspaces\ComputerVision\DontPanic.CV.Tracking\Externals\MongoDb\mongo.exe" --shell --host tfsbuild-eh
}

#Go to CV dir
$cvDir = "C:\workspaces\ComputerVision"
$workDir = "C:\workspaces"
$otherWorkDir = "D:\workspaces"
If(Test-Path $cvDir){
	cd $cvDir
}
ElseIf(Test-Path $workDir){
	cd $workDir
}
ElseIf(Test-Path $otherWorkDir){
	cd $otherWorkDir
}