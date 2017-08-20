InModuleScope HideWindowsExplorerDrives {
    Describe 'Show-DriveLetter' {
        Mock Test-ISadmin {$true}
        Context 'Drive Not Hidden' {
            Mock Set-HiddenDriveValue {}
            Mock Get-HiddenDriveValue { return 0}
            Mock Get-DriveStatus {
                [PSCustomObject]@{
                    DriveLetter = 'C'
                    IsHidden    = $false
                }
            }

            It 'Should not try to show the drive letter' {
                Show-DriveLetter -DriveLetter C
                Assert-MockCalled -CommandName Set-HiddenDriveValue -Times 0
            }
        }
        Context 'Drive Hidden' {
            Mock Set-HiddenDriveValue {}
            Mock Get-HiddenDriveValue { return 0}
            Mock Get-DriveStatus {
                [PSCustomObject]@{
                    DriveLetter = 'C'
                    IsHidden    = $true
                }
            }

            It 'Should show the drive letter' {
                Show-DriveLetter -DriveLetter C
                Assert-MockCalled -CommandName Set-HiddenDriveValue -Times 1
            }
        }
    }
}