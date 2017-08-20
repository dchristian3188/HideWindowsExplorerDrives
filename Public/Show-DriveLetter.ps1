Function Show-DriveLetter
{
    [CmdletBinding()]
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
        $isAdmin = Test-IsAdmin
        if ($isAdmin)
        {
            $letterMap = Get-LetterMap
        }
        else
        {
            Write-Warning "Must be an administrator to show drives"           
        }
    }
    Process
    {
        if ($isAdmin)
        {
            ForEach ($drive in $DriveLetter)
            {
                $driveStatus = Get-DriveStatus -DriveLetter $drive
                if ($driveStatus.IsHidden)
                {
                    $hiddenDrives = Get-HiddenDriveValue
                    $driveValue = $hiddenDrives - $letterMap[$drive]
                    Write-Verbose -Message "Showing Drive Letter [$drive]"
                    Set-HiddenDriveValue -NewValue $driveValue
                } 
                else
                {
                    Write-Verbose -Message "Drive [$drive] already shown"   
                }
            }
        }
        
    }
    End
    {
        Write-Verbose -Message "Please restart explorer for changes to take effect"
    }
}