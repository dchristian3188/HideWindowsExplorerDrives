Function Set-HiddenDriveValue
{
    Param([int]$NewValue)
    $HIDDEN_DRIVES_KEY = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\'
    $PROPERTY_NAME = "NoDrives"
    Set-ItemProperty -Path $HIDDEN_DRIVES_KEY -Name $PROPERTY_NAME -Value $NewValue -Force
}