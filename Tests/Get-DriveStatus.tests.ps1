InModuleScope HideWindowsExplorerDrives {
    Describe 'Get-DriveStatus' {
        Context 'Parameter Validation' {
            It 'Accepts a single drive letter' {
                {Get-DriveStatus -DriveLetter C} | Should not throw
                {Write-Output "C" | Get-DriveStatus } | Should not throw
            }

            It 'Accepts multiple drive letters' {
                {Get-DriveStatus -DriveLetter A,B,C} | Should not throw
                {Write-Output A B C | Get-DriveStatus } | Should not throw
            }
        }
        Context 'If no drives are hidden' {
            Mock Get-HiddenDriveValue {return 0}

            It 'Gets the right status' {
                $status = Get-DriveStatus | 
                    Group-Object -Property IsHidden
                $status[0].Count | Should be 26
                $status[0].Name | Should be 'False'
            }
        }
        Context 'If the C Drive is hidden' {
            Mock Get-HiddenDriveValue {return 4}

            It 'Gets the right count' {
                $status = Get-DriveStatus | 
                    Group-Object -Property IsHidden |
                    Sort-Object -Property Name

                $status[0].Count | Should be 25
                $status[0].Name | Should be 'False'
                $status[1].Count | Should be 1
                $status[1].Name | Should be 'true'
            }

            It 'Gets the right status' {
                (Get-DriveStatus -DriveLetter C).IsHidden | Should be $true
            }
        }    
    }
}