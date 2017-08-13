Function Get-DriveStatus
{
    Param(
        [Parameter(
            ValueFromPipeline
        )]
        [ValidatePattern('^[A-z]$')]
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