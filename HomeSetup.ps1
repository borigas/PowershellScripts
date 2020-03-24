& $PSScriptRoot\Setup.ps1


function InstallVboxVmService(){
  choco install vboxvmservice -y -ia '/DIR=""C:\Program Files\VBoxVmService""'
  cp "VBoxVmService\VBoxVmService.ini" "$env:ProgramFiles\VBoxVmService\VBoxVmService.ini"
}

$vbox = Read-Host "Install VirtualBox? (y/n)"
if($vbox.ToLower() -eq "y"){
    choco install virtualbox -y
    InstallVboxVmService
}