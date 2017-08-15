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
        if (!([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
        {
            Write-Warning "Must be an administrator to show drives"
            $isAdmin = $false
        } 
        else 
        {
            $isAdmin = $true
            $letterMap = Get-LetterMap
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