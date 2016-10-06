#### Set execution policy ####

#### Functions Used to Load VS Command Prompt #####

# Change home to end with a "\". Allows cd ~ when ~ was D:. Otherwise, it acts as a drive change, not a dir change
(get-psprovider filesystem).Home = (get-psprovider filesystem).Home + "\"

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
	if(Test-Path env:VS120COMNTOOLS){
		$vsComntools = (Get-ChildItem env:VS120COMNTOOLS).Value
		if(Test-Path $vsComntools){
			$version = "12.0"
			$batchFile = [System.IO.Path]::Combine($vsComntools, "vsvars32.bat")
			Get-Batchfile $batchFile
			[System.Console]::Title = "Powershell w/ Visual Studio " + $version
		}
	}
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

#$global:GitPromptSettings.WorkingForegroundColor    = [ConsoleColor]::Red 
#$global:GitPromptSettings.UntrackedForegroundColor  = [ConsoleColor]::Red
#$global:GitPromptSettings.IndexForegroundColor  = [ConsoleColor]::Green

if(!$IsAdmin){
    Start-SshAgent
}

function gitstatus { git status }
set-alias gsl gitstatus
function gitstatusshort { git status -s }
set-alias gs gitstatusshort
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
    . "C:\MongoDb\bin\mongo.exe" --shell --host HV-Mongo01
}

#Install Jump Location
Import-Module "$(Get-ProfileDirectory)\Modules\Jump-Location-0.6.0\Jump.Location.psd1"

#Install PsReadline
Import-Module PSReadLine

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