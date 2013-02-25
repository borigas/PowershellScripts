#### Functions Used to Load VS Command Prompt #####

function Get-Batchfile ($file) {
	$cmd = "`"$file`" & set"
	cmd /c $cmd | Foreach-Object {
		$p, $v = $_.split('=')
		Set-Item -path env:$p -value $v
	}
}

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
###### Functions Used to Load VS Command Prompt #####

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
		cls
	}
	else
	{
		$title = $title + " (Administrator)"
		(Get-Host).UI.RawUI.Backgroundcolor="Black"
	}
	[System.Console]::Title = $title
}

###### Run Functions on Startup ######
VsVars32
AmIAdmin

###### Set Aliases ######
set-alias notepad "C:\Program Files (x86)\Notepad++\notepad++.exe"
$hostfile = $env:SystemRoot + "\system32\drivers\etc\hosts"
function edit-hostfile { 
	$hostfilepath = $env:SystemRoot + "\system32\drivers\etc\hosts"
	notepad $hostfilepath 
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

function gitstatus { git status }
set-alias gs gitstatus
function gitpull { git pull }
set-alias pu gitpull

#Go to Beehive dir
cd C:\workspaces\ComputerVision