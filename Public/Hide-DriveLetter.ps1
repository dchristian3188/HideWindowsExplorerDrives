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
        if (!([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
        {
            Write-Warning "Must be an administrator to hide drives"
            $isAdmin = $false
        }
        else
        {
            $letterMap = Get-LetterMap
            $isAdmin = $true
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
                    Write-Verbose -Message "Drive Letter [$drive] already hidden"
                }
                else
                {
                    $hiddenDrives = Get-HiddenDriveValue
                    $driveValue = $hiddenDrives -bor $letterMap[$drive]
                    Write-Verbose -Message "Hidding Drive Letter [$drive]"
                    Set-HiddenDriveValue -NewValue $driveValue
                }
            
            }
        }
    }
    End
    {
        Write-Verbose -Message "Please restart explorer for changes to take effect"
    }
}