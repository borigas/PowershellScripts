# Save the initial location
Push-Location

$dest = "D:"

$replace = $env:UserProfile

<#
# For reversing the changess
$temp = $dest
$dest = $replace
$replace = $temp
#>

$filter = $replace + "*"

$appDataFolder = "$dest/AppData"

if(!(Test-Path -Path $appDataFolder)){
    Write-Output "You must copy data 1st. Run:"
    Write-Output "robocopy $replace $dest /mir /xj /copyall"
    Exit 1
}

Set-Location 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders'

Get-Item . | 
Select-Object -ExpandProperty property | 
ForEach-Object {
    New-Object psobject -Property @{
        "Name"=$_;
        "Value" = (Get-ItemProperty -Path . -Name $_).$_
        "NewValue" = ""
    }
} |
Where-Object {$_.Value -like $filter} |   
ForEach-Object {
    $_.NewValue = $_.Value.Replace($replace, $dest)
    return $_
} | 
ForEach-Object {
    Set-ItemProperty -Path . -Name $_.Name -Value $_.NewValue
    return $_
} |
Format-Table -AutoSize



$objUser = New-Object System.Security.Principal.NTAccount([Environment]::UserName)
$strSID = $objUser.Translate([System.Security.Principal.SecurityIdentifier])

$profileRegKey = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\$strSID"
Set-Location $profileRegKey

Set-ItemProperty -Path . -Name "ProfileImagePath" -Value $dest

# Restore the original location
Pop-Location
