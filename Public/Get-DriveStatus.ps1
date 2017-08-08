Function Get-DriveStatus
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
        $hiddenDrives = Get-HiddenDriveValue
        $letterMap = Get-LetterMap
    }
    
    Process
    {
        $lettersToCheck = $letterMap.Keys | 
            Sort-Object
        if ($DriveLetter)
        {
            $lettersToCheck = $lettersToCheck | 
                Where-Object {$PSItem -in $DriveLetter}
        }        
        foreach ($letter in $lettersToCheck)
        {
            $driveHidden = ($hiddenDrives -band $letterMap[$letter]) -eq $letterMap[$letter]
            [pscustomobject]@{
                DriveLetter = $letter
                IsHidden    = $driveHidden
            }
        }
    }
}