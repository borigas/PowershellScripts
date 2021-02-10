& $PSScriptRoot\Setup.ps1

choco install firefox -y
choco install microsoft-edge -y
choco install microsoft-teams -y
choco install office365business -y
choco install sql-server-management-studio -y
choco install sql-server-express -y
choco install visualstudio2019professional -y --config ./work.vsconfig
choco install microsoftazurestorageexplorer -y
choco install servicebusexplorer -y
choco install todobackup -y
choco install robo3t -y
choco install vlc -y

if ($PSVersionTable.PSEdition -eq 'Desktop' -and (Get-Module -Name AzureRM -ListAvailable)) {
    Write-Warning -Message ('Az module not installed. Having both the AzureRM and Az modules installed at the same time is not supported.')
} else {
    Install-Module -Name Az -AllowClobber -Scope CurrentUser
}

choco install MSMQ-Server --source WindowsFeatures
choco install Microsoft-Hyper-V --source WindowsFeatures
choco install Microsoft-Windows-Subsystem-Linux --source WindowsFeatures
choco install Containers-DisposableClientVM --source WindowsFeatures

choco install wsl-ubuntu-2004 -y
choco install docker-desktop -y