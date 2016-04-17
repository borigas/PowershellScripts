
$passwordSecure = Read-Host "Enter password: " -AsSecureString

$password = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($passwordSecure))
    
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

choco install googlechrome -y
choco install chrashplan -y
choco install virtualbox -y
    
InstallAutoHotKey($password)

InstallKeyboard

function InstallKeyboard {

    $url = "https://github.com/borigas/Settings/raw/master/CustomDvorak/MyDvorak_amd64.msi"

    Invoke-WebRequest -Uri $url -OutFile Keyboard.msi
    
    . Keyboard.msi /passive

    rm Keyboard.msi

    Write-Output "Installed Custom Keyboard"
}

function InstallAutoHotKey($password) {

    $installLocation = GetUtilitiesDirectory
    $ahkDir = "$installLocation/AutoHotKey"

    CreateIfNotExists($ahkDir)

    $ahkExePath = "$ahkDir/MyAutoHotKey.exe"

    $url = "https://github.com/borigas/Settings/blob/master/AutoHotKey/MyAutoHotKey.exe?raw=true"

    Invoke-WebRequest -Uri $url -OutFile $ahkExePath

    CreateAutoStartAtLoginTask($password, $ahkExePath)

    Write-Output "Installed AutoHotKey"
}

function GetFullUserName {
    $user = "$([Environment]::UserDomainName)\$([Environment]::UserName)"
    return $user
}

function GetUtilitiesDirectory {
    $userDir = [Environment]::GetFolderPath("UserProfile")
    $installLocation = "$userDir/Utilities"

    CreateIfNotExists($installLocation)
    
    return $installLocation
}

function CreateIfNotExists($path){
    if(!(Test-Path -Path $path)){
        New-Item -ItemType directory -Path $path
    }
}

function CreateAutoStartAtLoginTask($password, $command){

    $user = GetFullUserName

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
          <UserId>$user</UserId>
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

    schtasks /Create /XML task.xml /RU $user /RP $password /TN AutoHotKey /F

    rm task.xml
}