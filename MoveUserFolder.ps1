# Save the initial location
Push-Location

$dest = "D:"

$replace = $env:UserProfile

$filter = $replace + "*"


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
