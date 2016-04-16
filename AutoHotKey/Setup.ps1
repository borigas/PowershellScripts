$userDir = [Environment]::GetFolderPath("UserProfile")
$installLocation = "$userDir/Utilities"

if(!(Test-Path -Path $installLocation)){
    New-Item -ItemType directory -Path $installLocation
}

$ahkDir = "$installLocation/AutoHotKey"

if(!(Test-Path -Path $ahkDir)){
    New-Item -ItemType directory -Path $ahkDir
}

$ahkExePath = "$ahkDir/MyAutoHotKey.exe"

$exists = $False
if(Test-Path -Path $ahkExePath){
    rm $ahkExePath
    $exists = $True
}

$url = "https://github.com/borigas/Settings/blob/master/AutoHotKey/MyAutoHotKey.exe?raw=true"

Invoke-WebRequest -Uri $url -OutFile $ahkExePath

If(!$exists){
    schtasks /Delete /TN AutoHotKey
}

$user = "$([Environment]::UserDomainName)\$([Environment]::UserName)"

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
      <Command>$ahkExePath</Command>
    </Exec>
  </Actions>
</Task>"

$xml > task.xml

schtasks /Create /XML task.xml /RU $user /TN AutoHotKey

rm task.xml

Write-Output "Installed AutoHotKey"