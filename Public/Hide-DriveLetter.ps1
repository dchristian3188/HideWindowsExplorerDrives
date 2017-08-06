Function Hide-DriveLetter
{
    Param(
        [Parameter(
            ValueFromPipeline
        )]
        [ValidatePattern('[a-z]')]
        [ValidateLength(1, 1)]
        [String[]]
        $DriveLetter
    )
    Begin
    {
        $HIDDEN_DRIVES_KEY = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer\'
        $PROPERTY_NAME = "NoDrives"
        $letterMap = Get-LetterMap
    }
    Process
    {
        ForEach ($drive in $DriveLetter)
        {
            $driveStatus = Get-DriveStatus -DriveLetter $drive
            If ($driveStatus.IsHidden)
            {
                Write-Verbose -Message "Drive Letter [$drive] already hidden"
            }
            else
            {
                $hiddenDrives = (Get-Item -Path $HIDDEN_DRIVES_KEY).GetValue($PROPERTY_NAME)
                $driveValue = $hiddenDrives -bor $letterMap[$drive]
                Write-Verbose -Message "Hidding Drive Letter [$drive]"
                Set-ItemProperty -Path $HIDDEN_DRIVES_KEY -Name $PROPERTY_NAME -Value $driveValue -Force
            }
            
        }
    }
}