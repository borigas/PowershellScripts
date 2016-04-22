
function InstallKeyboard {
    
    ./CustomDvorak/setup.exe

    Write-Output "Installed Custom Keyboard"
}

function InstallAutoHotKey($password) {

    $ahkDir = "$(Get-Location)\AutoHotKey"

    $ahkExePath = "$ahkDir\MyAutoHotKey.exe"

    $taskName = "AutoHotKey"

    CreateAutoStartAtLoginTask $password $ahkExePath $taskName

    Write-Output "Installed AutoHotKey"
}

function InstallWinSplit($password) {

    $ahkDir = "$(Get-Location)\AutoHotKey"

    $ahkExePath = "$(Get-Location)\WinSplitRevolution\WinSplit.exe"

    $taskName = "WinSplit Revolution"

    CreateAutoStartAtLoginTask $password $ahkExePath $taskName

    Write-Output "Installed Win Split Revolution"
}

function GetFullUserName {
    $user = "$([Environment]::UserDomainName)\$([Environment]::UserName)"
    return $user
}

function CreateIfNotExists($path){
    if(!(Test-Path -Path $path)){
        New-Item -ItemType directory -Path $path
    }
}

function CreateAutoStartAtLoginTask($password, $command, $taskNamd){

    $user = GetFullUserName

    $objUser = New-Object System.Security.Principal.NTAccount([Environment]::UserName)
    $strSID = $objUser.Translate([System.Security.Principal.SecurityIdentifier])

    $xml = "<?xml version='1.0' encoding='UTF-16'?>
    <Task version='1.2' xmlns='http://schemas.microsoft.com/windows/2004/02/mit/task'>
      <RegistrationInfo>
        <Date>2013-01-10T14:50:59.8998405</Date>
        <Author>$user</Author>
      </RegistrationInfo>
      <Triggers>
        <LogonTrigger>
          <Enabled>true</Enabled>
          <UserId>$user</UserId>
        </LogonTrigger>
      </Triggers>
      <Principals>
        <Principal id='Author'>
          <UserId>$strSID</UserId>
          <LogonType>InteractiveToken</LogonType>
          <RunLevel>HighestAvailable</RunLevel>
        </Principal>
      </Principals>
      <Settings>
        <MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
        <DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries>
        <StopIfGoingOnBatteries>true</StopIfGoingOnBatteries>
        <AllowHardTerminate>true</AllowHardTerminate>
        <StartWhenAvailable>false</StartWhenAvailable>
        <RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAvailable>
        <IdleSettings>
          <StopOnIdleEnd>true</StopOnIdleEnd>
          <RestartOnIdle>false</RestartOnIdle>
        </IdleSettings>
        <AllowStartOnDemand>true</AllowStartOnDemand>
        <Enabled>true</Enabled>
        <Hidden>false</Hidden>
        <RunOnlyIfIdle>false</RunOnlyIfIdle>
        <WakeToRun>false</WakeToRun>
        <ExecutionTimeLimit>PT0S</ExecutionTimeLimit>
        <Priority>7</Priority>
      </Settings>
      <Actions Context='Author'>
        <Exec>
          <Command>$command</Command>
        </Exec>
      </Actions>
    </Task>"

    $xml > task.xml

    schtasks /Create /XML "task.xml" /IT /RU $user /RP $password /TN $taskName /F

    rm task.xml
}

iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

choco install googlechrome -y
choco install virtualbox -y
choco install notepadplusplus -y
choco install github -y

cd ~
git clone https://github.com/borigas/Settings

cd Settings

InstallKeyboard

$passwordSecure = Read-Host "Enter password: " -AsSecureString

$password = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($passwordSecure))

InstallAutoHotKey($password)
InstallWinSplit($password)