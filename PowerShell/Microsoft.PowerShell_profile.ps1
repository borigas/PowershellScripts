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
	if(Test-Path env:VS140COMNTOOLS){
		$vsComntools = (Get-ChildItem env:VS140COMNTOOLS).Value
		if(Test-Path $vsComntools){
			$version = "14.0"
			$batchFile = [System.IO.Path]::Combine($vsComntools, "vsvars32.bat")
			Get-Batchfile $batchFile
			[System.Console]::Title = "Powershell w/ Visual Studio " + $version
		}
	}
	elseif(Test-Path env:VS120COMNTOOLS){
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
$notepadPlusPlusPathOptions = @("C:\Program Files\Notepad++\notepad++.exe", "C:\Program Files (x86)\Notepad++\notepad++.exe")
foreach ($possibleNppPath in $notepadPlusPlusPathOptions){
	if (Test-Path $possibleNppPath){
		set-alias notepad $possibleNppPath
	}
}

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

#$global:GitPromptSettings.WorkingForegroundColor    = [ConsoleColor]::Red 
#$global:GitPromptSettings.UntrackedForegroundColor  = [ConsoleColor]::Red
#$global:GitPromptSettings.IndexForegroundColor  = [ConsoleColor]::Green

set-alias g git
function gitstatus { git status }
set-alias gsl gitstatus
function gitstatusshort { git shorty }
set-alias gs gitstatusshort
function gitdiff { git diff }
set-alias gd gitdiff
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

Import-Module posh-git

Import-Module z

$isDefaultLocation = (Get-Location).Path -eq "C:\Windows\System32"
if($isDefaultLocation){
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
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

function RemotePs($computerName, $userName) {
	$session = NewPsSession $computerName $userName
	Enter-PSSession $session
}
function NewPsSession($computerName, $userName) {
	$session = New-PSSession -UseSSL -Credential $userName -SessionOption (New-PSSessionOption -SkipCACheck -SkipCNCheck) -ComputerName $computerName
	return $session
}