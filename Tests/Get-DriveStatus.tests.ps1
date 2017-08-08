InModuleScope HideWindowsExplorerDrives {
    Describe 'Get-DriveStatus' {
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

            It 'Gets the right status' {
                $status = Get-DriveStatus | 
                    Group-Object -Property IsHidden
                $status.Count | Should be 26
                $status.Name | Should be 'False'
            }
        }    
    }
}