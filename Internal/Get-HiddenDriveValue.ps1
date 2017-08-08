Function Get-HiddenDriveValue
{
    $HIDDEN_DRIVES_KEY = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\'
    (Get-Item -Path $HIDDEN_DRIVES_KEY).GetValue("NoDrives")
}